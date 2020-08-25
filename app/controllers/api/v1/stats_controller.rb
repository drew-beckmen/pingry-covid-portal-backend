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
            percentBaskingRidgeActiveIsolationOrQuarantine: percent_basking_ridge_in_quarantine_or_isolation.round(2), 
            percentShortHillsActiveIsolationOrQuarantine: percent_short_hills_in_quarantine_or_isolation.round(2), 
            percentPingryActiveIsolationOrQuarantine: get_percent_pingry_in_q_or_i.round(2),
            past72IsolationsShortHills: new_isolations_72_hours_short_hills.length, 
            past72IsolationsBaskingRidge: new_isolations_72_hours_basking_ridge.length, 
            past72QuarantinesShortHills: new_quarantines_72_hours_short_hills.length, 
            past72QuarantinesBaskingRidge: new_quarantines_72_hours_basking_ridge.length, 
            cohort1ShortHills: cohort_1_short_hills.length, 
            cohort1BaskingRidge: cohort_1_basking_ridge.length, 
            cohort1ActiveIsolationsShortHills: cohort_1_short_hills_active_isolations, 
            cohort1ActiveIsolationsBaskingRidge: cohort_1_basking_ridge_active_isolations, 
            cohort1ActiveQuarantinesShortHills: cohort_1_short_hills_active_quarantines,
            cohort1ActiveQuarantinesBaskingRidge: cohort_1_basking_ridge_active_quarantines,
            cohort1NewIsolationsShortHills: cohort_1_new_isolations_72_hours_short_hills, 
            cohort1NewIsolationsBaskingRidge: cohort_1_new_isolations_72_hours_basking_ridge, 
            cohort1NewQuarantinesShortHills: cohort_1_new_quarantines_72_hours_short_hills, 
            cohort1NewQuarantinesBaskingRidge: cohort_1_new_quarantines_72_hours_basking_ridge, 
            cohort2ShortHills: cohort_2_short_hills.length, 
            cohort2BaskingRidge: cohort_2_basking_ridge.length, 
            cohort2ActiveIsolationsShortHills: cohort_2_short_hills_active_isolations, 
            cohort2ActiveIsolationsBaskingRidge: cohort_2_basking_ridge_active_isolations, 
            cohort2ActiveQuarantinesShortHills: cohort_2_short_hills_active_quarantines,
            cohort2ActiveQuarantinesBaskingRidge: cohort_2_basking_ridge_active_quarantines,
            cohort2NewIsolationsShortHills: cohort_2_new_isolations_72_hours_short_hills, 
            cohort2NewIsolationsBaskingRidge: cohort_2_new_isolations_72_hours_basking_ridge, 
            cohort2NewQuarantinesShortHills: cohort_2_new_quarantines_72_hours_short_hills, 
            cohort2NewQuarantinesBaskingRidge: cohort_2_new_quarantines_72_hours_basking_ridge, 
            shortHillsAdults: short_hills_adults.length, 
            baskingRidgeAdults: basking_ridge_adults.length, 
            shortHillsAdultsActiveIsolations: get_active_isolations_adults_short_hills, 
            shortHillsAdultsActiveQuarantines: get_active_quarantines_adults_short_hills,
            baskingRidgeAdultsActiveIsolations: get_active_isolations_adults_basking_ridge, 
            baskingRidgeAdultsActiveQuarantines: get_active_quarantines_adults_basking_ridge, 
            outOfSchoolHash: number_people_out_of_school
        }
    end 


    private 
    def get_short_hills_students
        Student.all.select{|student| student.campus == "Short Hills"} #&& !student.teacher}
    end   
    
    def get_basking_ridge_students 
        Student.all.select{|student| student.campus == "Basking Ridge"} # && !student.teacher}
    end 

    def short_hills_adults 
        Student.all.select{|student| student.campus == "Short Hills" && student.teacher}
    end 

    def get_active_isolations_adults_short_hills 
        short_hills_adults.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def get_active_quarantines_adults_short_hills 
        short_hills_adults.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end 

    def get_active_isolations_adults_basking_ridge
        basking_ridge_adults.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def get_active_quarantines_adults_basking_ridge
        basking_ridge_adults.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end 

    def basking_ridge_adults 
        Student.all.select{|student| student.campus == "Basking Ridge" && student.teacher}
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
        list_isolations_short_hills.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)} 
    end

    def cohort_1_short_hills
        get_short_hills_students.select{|s| s.cohort == "Group 1"} 
    end 

    def cohort_1_basking_ridge
        get_basking_ridge_students.select{|s| s.cohort == "Group 1"} 
    end
    
    def cohort_1_short_hills_active_isolations
        cohort_1_short_hills.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def cohort_1_basking_ridge_active_isolations
        cohort_1_basking_ridge.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def cohort_1_short_hills_active_quarantines
        cohort_1_short_hills.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end 

    def cohort_1_basking_ridge_active_quarantines
        cohort_1_basking_ridge.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end

    def cohort_1_new_isolations_72_hours_short_hills 
        new_isolations_72_hours_short_hills.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 1"
        }.length 
    end 

    def cohort_1_new_isolations_72_hours_basking_ridge
        new_isolations_72_hours_basking_ridge.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 1"
        }.length 
    end 

    def cohort_1_new_quarantines_72_hours_basking_ridge
        new_quarantines_72_hours_basking_ridge.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 1"
        }.length 
    end 

    def cohort_1_new_quarantines_72_hours_short_hills
        new_quarantines_72_hours_short_hills.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 1"
        }.length 
    end 

    def cohort_2_short_hills
        get_short_hills_students.select{|s| s.cohort == "Group 2"} 
    end 

    def cohort_2_basking_ridge
        get_basking_ridge_students.select{|s| s.cohort == "Group 2"} 
    end
    
    def cohort_2_short_hills_active_isolations
        cohort_2_short_hills.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def cohort_2_basking_ridge_active_isolations
        cohort_2_basking_ridge.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    end 

    def cohort_2_short_hills_active_quarantines
        cohort_2_short_hills.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end 

    def cohort_2_basking_ridge_active_quarantines
        cohort_2_basking_ridge.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    end

    def cohort_2_new_isolations_72_hours_short_hills 
        new_isolations_72_hours_short_hills.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 2"
        }.length 
    end 

    def cohort_2_new_isolations_72_hours_basking_ridge
        new_isolations_72_hours_basking_ridge.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 2"
        }.length 
    end 

    def cohort_2_new_quarantines_72_hours_basking_ridge
        new_quarantines_72_hours_basking_ridge.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 2"
        }.length 
    end 

    def cohort_2_new_quarantines_72_hours_short_hills
        new_quarantines_72_hours_short_hills.select{|iso| 
            Student.find(iso.student_id).cohort == "Group 2"
        }.length 
    end 

    def new_isolations_72_hours_basking_ridge
        list_isolations_basking_ridge.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)} 
    end

    def new_quarantines_72_hours_short_hills 
        list_quarantines_short_hills.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)} 
    end 

    def new_quarantines_72_hours_basking_ridge
        list_quarantines_basking_ridge.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)} 
    end 

    # Graph that shows date and number of people out of school 
    def number_people_out_of_school 
        mapping = {Date.today => 0, Date.today + 1 => 1, Date.today + 2 => 2, Date.today + 3 => 3, Date.today + 4 => 4}
        final_hash = [{"name" => Date.today, "students" => 0, "teachers" => 0, "total" => 0}, {"name" => Date.today + 1, "students" => 0, "teachers" => 0, "total" => 0}, {"name" => Date.today + 2, "students" => 0, "teachers" => 0, "total" => 0}, {"name" => Date.today + 3, "students" => 0, "teachers" => 0, "total" => 0}, {"name" => Date.today + 4, "students" => 0, "teachers" => 0, "total" => 0}]
        date_keys = final_hash.map{|obj| obj["name"]}
        date_keys.each do |key|  
            Isolation.all.each do |iso| 
                if iso.end_date > key && !iso.completed
                    final_hash[mapping[key]]["total"] += 1
                    if Student.find(iso.student_id).teacher 
                        final_hash[mapping[key]]["teachers"] += 1
                    else 
                        final_hash[mapping[key]]["students"] += 1
                    end 
                end 
            end 
            Quarantine.all.each do |q| 
                if q.exposure + 14 > key && !q.completed
                    final_hash[mapping[key]]["total"] += 1
                    if Student.find(q.student_id).teacher 
                        final_hash[mapping[key]]["teachers"] += 1
                    else
                        final_hash[mapping[key]]["students"] += 1
                    end 
                end 
            end
        end
        final_hash
    end 

end

