require 'date'

class Api::V1::StatsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index 
        # render json: {
        #     studentsBaskingRidge: get_basking_ridge_students, 
        #     totalIsolationsBaskingRidge: get_total_isolations_basking_ridge, 
        #     totalQuarantinesBaskingRidge: get_total_quarantines_basking_ridge,
        #     totalActiveIsolationsBaskingRidge: get_active_isolations_basking_ridge, 
        #     totalActiveQuarantinesBaskingRidge: get_active_quarantines_basking_ridge, 
        #     percentBaskingRidgeActiveIsolationOrQuarantine: percent_basking_ridge_in_quarantine_or_isolation.round(2), 
        #     percentPingryActiveIsolationOrQuarantine: get_percent_pingry_in_q_or_i.round(2),
        #     past72IsolationsBaskingRidge: new_isolations_72_hours_basking_ridge.length, 
        #     past72QuarantinesBaskingRidge: new_quarantines_72_hours_basking_ridge.length, 
        #     cohort1BaskingRidge: cohort_1_basking_ridge.length, 
        #     cohort1ActiveIsolationsBaskingRidge: cohort_1_basking_ridge_active_isolations, 
        #     cohort1ActiveQuarantinesBaskingRidge: cohort_1_basking_ridge_active_quarantines,
        #     cohort1NewIsolationsBaskingRidge: cohort_1_new_isolations_72_hours_basking_ridge, 
        #     cohort1NewQuarantinesBaskingRidge: cohort_1_new_quarantines_72_hours_basking_ridge, 
        #     cohort2BaskingRidge: cohort_2_basking_ridge, 
        #     cohort2ActiveIsolationsBaskingRidge: cohort_2_basking_ridge_active_isolations, 
        #     cohort2ActiveQuarantinesBaskingRidge: cohort_2_basking_ridge_active_quarantines,
        #     cohort2NewIsolationsBaskingRidge: cohort_2_new_isolations_72_hours_basking_ridge, 
        #     cohort2NewQuarantinesBaskingRidge: cohort_2_new_quarantines_72_hours_basking_ridge, 
        #     baskingRidgeAdults: basking_ridge_adults, 
        #     baskingRidgeAdultsActiveIsolations: get_active_isolations_adults_basking_ridge, 
        #     baskingRidgeAdultsActiveQuarantines: get_active_quarantines_adults_basking_ridge, 
        #     outOfSchoolHash: number_people_out_of_school
        # }
        short_hills_array = short_hills_master
        basking_ridge_array = basking_ridge_master
        percentBaskingRidge = ((basking_ridge_array[3].to_f + basking_ridge_array[4])/(basking_ridge_array[0].to_f)) * 100
        percentShortHills = ((short_hills_array[3].to_f + short_hills_array[4])/(short_hills_array[0].to_f)) * 100
        overallPercent = ((basking_ridge_array[3].to_f + basking_ridge_array[4] + short_hills_array[3] + short_hills_array[4])/(basking_ridge_array[0] + short_hills_array[0])) * 100
        render json: {
                studentsShortHills: short_hills_array[0], 
                totalIsolationsShortHills: short_hills_array[1], 
                totalQuarantinesShortHills: short_hills_array[2], 
                totalActiveIsolationsShortHills: short_hills_array[3], 
                totalActiveQuarantinesShortHills: short_hills_array[4], 
                percentShortHillsActiveIsolationOrQuarantine: percentShortHills.round(2),
                past72IsolationsShortHills: short_hills_array[9], 
                past72QuarantinesShortHills: short_hills_array[10], 
                cohort1ShortHills: short_hills_array[11], 
                cohort1ActiveIsolationsShortHills: short_hills_array[5], 
                cohort1ActiveQuarantinesShortHills: short_hills_array[7],
                cohort1NewIsolationsShortHills: short_hills_array[13], 
                cohort1NewQuarantinesShortHills: short_hills_array[14], 
                cohort2ShortHills: short_hills_array[12], 
                cohort2ActiveIsolationsShortHills: short_hills_array[6], 
                cohort2ActiveQuarantinesShortHills: short_hills_array[8],
                cohort2NewIsolationsShortHills: short_hills_array[14], 
                cohort2NewQuarantinesShortHills: short_hills_array[16], 
                shortHillsAdults: short_hills_array[19], 
                shortHillsAdultsActiveIsolations: short_hills_array[18], 
                shortHillsAdultsActiveQuarantines: short_hills_array[17], 
                studentsBaskingRidge: basking_ridge_array[0], 
                totalIsolationsBaskingRidge: basking_ridge_array[1], 
                totalQuarantinesBaskingRidge: basking_ridge_array[2],
                totalActiveIsolationsBaskingRidge: basking_ridge_array[3], 
                totalActiveQuarantinesBaskingRidge: basking_ridge_array[4], 
                percentBaskingRidgeActiveIsolationOrQuarantine: percentBaskingRidge.round(2), 
                percentPingryActiveIsolationOrQuarantine: overallPercent.round(2),
                past72IsolationsBaskingRidge: basking_ridge_array[9], 
                past72QuarantinesBaskingRidge: basking_ridge_array[10], 
                cohort1BaskingRidge: basking_ridge_array[11], 
                cohort1ActiveIsolationsBaskingRidge: basking_ridge_array[5], 
                cohort1ActiveQuarantinesBaskingRidge: basking_ridge_array[7],
                cohort1NewIsolationsBaskingRidge: basking_ridge_array[13], 
                cohort1NewQuarantinesBaskingRidge: basking_ridge_array[14], 
                cohort2BaskingRidge: basking_ridge_array[12], 
                cohort2ActiveIsolationsBaskingRidge: basking_ridge_array[6], 
                cohort2ActiveQuarantinesBaskingRidge: basking_ridge_array[8],
                cohort2NewIsolationsBaskingRidge: basking_ridge_array[14], 
                cohort2NewQuarantinesBaskingRidge: basking_ridge_array[16], 
                baskingRidgeAdults: basking_ridge_array[19], 
                baskingRidgeAdultsActiveIsolations: basking_ridge_array[18], 
                baskingRidgeAdultsActiveQuarantines: basking_ridge_array[17], 
                outOfSchoolHash: number_people_out_of_school
        }
    end 


    private

    def get_short_hills_people
        Student.all.select{|student| student.campus == "Short Hills"} #&& !student.teacher}
    end

    def short_hills_master
        stats_calculator(get_short_hills_people)
    end 

    def basking_ridge_master 
        stats_calculator(get_basking_ridge_people)
    end 

        
    def get_basking_ridge_people
        Student.all.select{|student| student.campus == "Basking Ridge"} # && !student.teacher}
    end 

    def stats_calculator(all_people)
        totalIso = 0 
        totalQ = 0 
        activeIso = 0 
        activeQ = 0
        cohort1ActiveIso = 0 
        cohort2ActiveIso = 0 
        cohort1ActiveQ = 0 
        cohort2ActiveQ = 0 
        newIso = 0 
        newQ = 0 
        cohort1People = 0
        cohort2People = 0
        newIsoCohort1 = 0 
        newIsoCohort2 = 0
        newQCohort1 = 0 
        newQCohort2 = 0
        teacherActiveQ = 0 
        teacherActiveI = 0 
        teacherTotal = 0

        totalPeople = all_people.length 

        all_people.each do |person|
            totalIso += person.isolations.length 
            totalQ += person.quarantines.length 
            addToActiveIso = 0
            addToNewIso = 0 
            person.isolations.each do |iso|
                addToActiveIso += 1 if !iso.completed
                addToNewIso += 1 if ((Date.today-3)..Date.today).include?(iso.start_isolation)
            end
            activeIso += addToActiveIso

            addToActiveQ = 0 
            addToNewQ = 0 
            person.quarantines.each do |q| 
                addToActiveQ += 1 if !q.completed 
                addToNewQ += 1 if ((Date.today-3)..Date.today).include?(q.exposure)
            end 
            activeQ += addToActiveQ
            newIso += addToNewIso
            newQ += addToNewQ
            if person.cohort == "Group 1"
                cohort1People += 1 
                cohort1ActiveIso += addToActiveIso
                cohort1ActiveQ += addToActiveQ
                newIsoCohort1 += addToNewIso
                newQCohort1 += addToNewQ
            elsif person.cohort == "Group 2" 
                cohort2People += 1 
                cohort2ActiveIso += addToActiveIso
                cohort2ActiveQ += addToActiveQ
                newIsoCohort2 += addToNewIso
                newQCohort2 += addToNewQ
            elsif person.teacher 
                teacherTotal += 1
                teacherActiveI += addToActiveIso
                teacherActiveQ += addToActiveQ
            end 
        end 
        [totalPeople, totalIso, totalQ, activeIso, activeQ, cohort1ActiveIso, cohort2ActiveIso, cohort1ActiveQ, cohort2ActiveQ, newIso, newQ, cohort1People, cohort2People, newIsoCohort1, newIsoCohort2, newQCohort1, newQCohort2, teacherActiveQ, teacherActiveI, teacherTotal]
    end 
    
    # def get_basking_ridge_students 
    #     Student.all.select{|student| student.campus == "Basking Ridge"} # && !student.teacher}
    # end 

    # def short_hills_adults 
    #     Student.all.select{|student| student.campus == "Short Hills" && student.teacher}
    # end 

    # def get_active_isolations_adults_short_hills 
    #     short_hills_adults.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def get_active_quarantines_adults_short_hills 
    #     short_hills_adults.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end 

    # def get_active_isolations_adults_basking_ridge
    #     basking_ridge_adults.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def get_active_quarantines_adults_basking_ridge
    #     basking_ridge_adults.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end 

    # def basking_ridge_adults 
    #     Student.all.select{|student| student.campus == "Basking Ridge" && student.teacher}
    # end 

    # def get_total_isolations_short_hills 
    #     get_short_hills_students.reduce(0) {|sum, student| sum + student.isolations.length }
    # end    

    # def get_total_isolations_basking_ridge
    #     get_basking_ridge_students.reduce(0) {|sum, student| sum + student.isolations.length }
    # end 

    # def get_total_quarantines_short_hills 
    #     get_short_hills_students.reduce(0) {|sum, student| sum + student.quarantines.length }
    # end 

    # def get_total_quarantines_basking_ridge 
    #     get_basking_ridge_students.reduce(0) {|sum, student| sum + student.quarantines.length }
    # end 

    # def get_active_isolations_short_hills 
    #     get_short_hills_students.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def get_active_isolations_basking_ridge
    #     get_basking_ridge_students.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def get_active_quarantines_short_hills
    #     get_short_hills_students.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end

    # def get_active_quarantines_basking_ridge
    #     get_basking_ridge_students.reduce(0) {|sum, student| sum + student.quarantines.select{|q| !q.completed}.length }
    # end 

    # def percent_basking_ridge_in_quarantine_or_isolation
    #     (get_active_isolations_basking_ridge + get_active_quarantines_basking_ridge) / get_basking_ridge_students.length.to_f * 100
    # end 

    # def percent_short_hills_in_quarantine_or_isolation 
    #     (get_active_isolations_short_hills + get_active_quarantines_short_hills) / get_short_hills_students.length.to_f * 100
    # end    
    
    # def get_percent_pingry_in_q_or_i
    #     (get_active_isolations_basking_ridge + get_active_quarantines_basking_ridge + get_active_isolations_short_hills + get_active_quarantines_short_hills) / (Student.all.length.to_f) * 100
    # end

    # def list_isolations_short_hills 
    #     get_short_hills_students.map{|s| s.isolations }.flatten 
    # end 

    # def list_isolations_basking_ridge
    #     get_basking_ridge_students.map{|s| s.isolations }.flatten 
    # end 

    # def list_quarantines_short_hills
    #     get_short_hills_students.map{|s| s.quarantines}.flatten 
    # end 

    # def list_quarantines_basking_ridge
    #     get_basking_ridge_students.map{|s| s.quarantines}.flatten 
    # end 

    # def new_isolations_72_hours_short_hills 
    #     list_isolations_short_hills.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)} 
    # end

    # def cohort_1_short_hills
    #     get_short_hills_students.select{|s| s.cohort == "Group 1"} 
    # end 

    # def cohort_1_basking_ridge
    #     get_basking_ridge_students.select{|s| s.cohort == "Group 1"} 
    # end
    
    # def cohort_1_short_hills_active_isolations
    #     cohort_1_short_hills.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def cohort_1_basking_ridge_active_isolations
    #     cohort_1_basking_ridge.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def cohort_1_short_hills_active_quarantines
    #     cohort_1_short_hills.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end 

    # def cohort_1_basking_ridge_active_quarantines
    #     cohort_1_basking_ridge.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end

    # def cohort_1_new_isolations_72_hours_short_hills 
    #     new_isolations_72_hours_short_hills.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 1"
    #     }.length 
    # end 

    # def cohort_1_new_isolations_72_hours_basking_ridge
    #     new_isolations_72_hours_basking_ridge.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 1"
    #     }.length 
    # end 

    # def cohort_1_new_quarantines_72_hours_basking_ridge
    #     new_quarantines_72_hours_basking_ridge.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 1"
    #     }.length 
    # end 

    # def cohort_1_new_quarantines_72_hours_short_hills
    #     new_quarantines_72_hours_short_hills.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 1"
    #     }.length 
    # end 

    # def cohort_2_short_hills
    #     get_short_hills_students.select{|s| s.cohort == "Group 2"} 
    # end 

    # def cohort_2_basking_ridge
    #     get_basking_ridge_students.select{|s| s.cohort == "Group 2"} 
    # end
    
    # def cohort_2_short_hills_active_isolations
    #     cohort_2_short_hills.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def cohort_2_basking_ridge_active_isolations
    #     cohort_2_basking_ridge.reduce(0) {|sum, student| sum + student.isolations.select{|i| !i.completed}.length }
    # end 

    # def cohort_2_short_hills_active_quarantines
    #     cohort_2_short_hills.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end 

    # def cohort_2_basking_ridge_active_quarantines
    #     cohort_2_basking_ridge.reduce(0) {|sum, student| sum + student.quarantines.select{|i| !i.completed}.length }
    # end

    # def cohort_2_new_isolations_72_hours_short_hills 
    #     new_isolations_72_hours_short_hills.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 2"
    #     }.length 
    # end 

    # def cohort_2_new_isolations_72_hours_basking_ridge
    #     new_isolations_72_hours_basking_ridge.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 2"
    #     }.length 
    # end 

    # def cohort_2_new_quarantines_72_hours_basking_ridge
    #     new_quarantines_72_hours_basking_ridge.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 2"
    #     }.length 
    # end 

    # def cohort_2_new_quarantines_72_hours_short_hills
    #     new_quarantines_72_hours_short_hills.select{|iso| 
    #         Student.find(iso.student_id).cohort == "Group 2"
    #     }.length 
    # end 

    # def new_isolations_72_hours_basking_ridge
    #     list_isolations_basking_ridge.select{|iso| ((Date.today-3)..Date.today).include?(iso.start_isolation)} 
    # end

    # def new_quarantines_72_hours_short_hills 
    #     list_quarantines_short_hills.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)} 
    # end 

    # def new_quarantines_72_hours_basking_ridge
    #     list_quarantines_basking_ridge.select{|q| ((Date.today-3)..Date.today).include?(q.exposure)} 
    # end 

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

