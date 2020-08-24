require 'date'

class Api::V1::StatsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index 
        render json: {
            studentsShortHills: get_short_hills_students.length, 
            studentsBaskingRidge: get_basking_ridge_students.length, 
            totalIsolationsShortHills: get_total_isolations_short_hills, 
            totalIsolationsBaskingRidge: get_total_isolations_basking_ridge, 
            totalQuarantinesShortHills: get_total_quarantines_short_hills, 
            totalQuarantinesBaskingRidge: get_total_quarantines_basking_ridge,
            totalActiveIsolationsShortHills: get_active_isolations_short_hills, 
            totalActiveIsolationsBaskingRidge: get_active_isolations_basking_ridge, 
            totalActiveQuarantinesShortHills: get_active_quarantines_short_hills, 
            totalActiveQuarantinesBaskingRidge: get_active_quarantines_basking_ridge, 
            percentBaskingRidgeActiveIsolationOrQuarantine: percent_basking_ridge_in_quarantine_or_isolation, 
            percentShortHillsActiveIsolationOrQuarantine: percent_short_hills_in_quarantine_or_isolation, 
            percentPingryActiveIsolationOrQuarantine: get_percent_pingry_in_q_or_i,
            past72IsolationsShortHills: new_isolations_72_hours_short_hills, 
            past72IsolationsBaskingRidge: new_isolations_72_hours_basking_ridge, 
            past72QuarantinesShortHills: new_quarantines_72_hours_short_hills, 
            past72QuarantinesBaskingRidge: new_quarantines_72_hours_basking_ridge, 
            outOfSchoolHash: number_people_out_of_school
        }
    end 


    private 
    def get_short_hills_students
        Student.all.select{|student| student.campus == "Short Hills"}
    end   
    
    def get_basking_ridge_students 
        Student.all.select{|student| student.campus == "Basking Ridge"}
    end 

    def get_total_isolations_short_hills 
        get_short_hills_students.reduce(0) {|sum, student| sum + student.isolations.length }
    end    

    def get_total_isolations_basking_ridge
        get_basking_ridge_students.reduce(0) {|sum, student| sum + student.isolations.length }
    end 

    def get_total_quarantines_short_hills 
        get_short_hills_students.reduce(0) {|sum, student| sum + student.quarantines.length }
    end 

    def get_total_quarantines_basking_ridge 
        get_basking_ridge_students.reduce(0) {|sum, student| sum + student.quarantines.length }
    end 

    def get_active_isolations_short_hills 
        get_short_hills_students.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def get_active_isolations_basking_ridge
        get_basking_ridge_students.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def get_active_quarantines_short_hills
        get_short_hills_students.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end

    def get_active_quarantines_basking_ridge
        get_basking_ridge_students.reduce(0) {|sum, student| sum + student.quarantines.select{|q| !q.completed}.length }
    end 

    def percent_basking_ridge_in_quarantine_or_isolation
        (get_active_isolations_basking_ridge + get_active_quarantines_basking_ridge) / get_basking_ridge_students.length.to_f * 100
    end 

    def percent_short_hills_in_quarantine_or_isolation 
        (get_active_isolations_short_hills + get_active_quarantines_short_hills) / get_short_hills_students.length.to_f * 100
    end    
    
    def get_percent_pingry_in_q_or_i
        (get_active_isolations_basking_ridge + get_active_quarantines_basking_ridge + get_active_isolations_short_hills + get_active_quarantines_short_hills) / (Student.all.length.to_f) * 100
    end

    def list_isolations_short_hills 
        get_short_hills_students.map{|s| s.isolations }.flatten 
    end 

    def list_isolations_basking_ridge
        get_basking_ridge_students.map{|s| s.isolations }.flatten 
    end 

    def list_quarantines_short_hills
        get_short_hills_students.map{|s| s.quarantines}.flatten 
    end 

    def list_quarantines_basking_ridge
        get_basking_ridge_students.map{|s| s.quarantines}.flatten 
    end 

    def new_isolations_72_hours_short_hills 
        list_isolations_short_hills.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)}.length 
    end

    def new_isolations_72_hours_basking_ridge
        list_isolations_basking_ridge.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)}.length 
    end

    def new_quarantines_72_hours_short_hills 
        list_quarantines_short_hills.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)}.length 
    end 

    def new_quarantines_72_hours_basking_ridge
        list_quarantines_basking_ridge.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)}.length 
    end 

    # Graph that shows date and number of people out of school 
    def number_people_out_of_school 
        mapping = {Date.today => 0, Date.today + 1 => 1, Date.today + 2 => 2, Date.today + 3 => 3, Date.today + 4 => 4}
        final_hash = [{"name" => Date.today, "students" => 0}, {"name" => Date.today + 1, "students" => 0}, {"name" => Date.today + 2, "students" => 0}, {"name" => Date.today + 3, "students" => 0}, {"name" => Date.today + 4, "students" => 0}]
        date_keys = final_hash.map{|obj| obj["name"]}
        date_keys.each do |key|  
            Isolation.all.each do |iso| 
                if iso.end_date > key 
                    # byebug
                    final_hash[mapping[key]]["students"] += 1
                end 
            end 
            Quarantine.all.each do |q| 
                if q.exposure + 14 > key 
                    final_hash[mapping[key]]["students"] += 1

                end 
            end 
        end 
        final_hash
    end 

end

