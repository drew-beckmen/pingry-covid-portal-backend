require 'date'

class Api::V1::StatsController < ApplicationController
    skip_before_action :authorized, only: [:summary, :details]
    skip_before_action :write_access, only: [:summary, :index, :details, :q_and_i_each_campus, :past_future_7_details]
    def index 
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
                cohort2NewIsolationsShortHills: short_hills_array[15], 
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
                cohort2NewIsolationsBaskingRidge: basking_ridge_array[15], 
                cohort2NewQuarantinesBaskingRidge: basking_ridge_array[16], 
                baskingRidgeAdults: basking_ridge_array[19], 
                baskingRidgeAdultsActiveIsolations: basking_ridge_array[18], 
                baskingRidgeAdultsActiveQuarantines: basking_ridge_array[17], 
                outOfSchoolHash: number_people_out_of_school
        }
    end

    def summary 
        short_hills_array = short_hills_master
        basking_ridge_array = basking_ridge_master
        percentBaskingRidge = ((basking_ridge_array[3].to_f + basking_ridge_array[4])/(basking_ridge_array[0].to_f)) * 100
        percentShortHills = ((short_hills_array[3].to_f + short_hills_array[4])/(short_hills_array[0].to_f)) * 100
        overallPercent = ((basking_ridge_array[3].to_f + basking_ridge_array[4] + short_hills_array[3] + short_hills_array[4])/(basking_ridge_array[0] + short_hills_array[0])) * 100
        render json: {
            percentShortHillsActiveIsolationOrQuarantine: percentShortHills.round(2),
            percentBaskingRidgeActiveIsolationOrQuarantine: percentBaskingRidge.round(2), 
            percentPingryActiveIsolationOrQuarantine: overallPercent.round(2)
        }
    end

    # This is for internal facing dashboard 
    def past_future_7_details 
        sh, br = all_details
        sh = sh[6...21]
        br = br[6...21]
        sh_counter = -7
        br_counter = -7
        sh = sh.each_with_object([]) do |p, memo|
            memo << {"name" => (Date.today + sh_counter), "%qi" => p} 
            sh_counter += 1
        end 
        br_counter = -7
        br = br.each_with_object([]) do |p, memo|
            memo << {"name" => (Date.today + br_counter), "%qi" => p} 
            br_counter += 1
        end 
        render json: {
            shortHillsPercentage14Days: sh, 
            baskingRidgePercentage14Days: br
        }
    end 
    
    # This is for Jeffrey's external facing dashboard 
    def details 
        sh, br = all_details
        sh = sh[0...14]
        br = br[0...14]
        render json: {
            shortHillsPercentage14Days: sh, 
            baskingRidgePercentage14Days: br
        }
    end 

    # This is for the new graphs on the home page
    def q_and_i_each_campus 
        short_hills, basking_ridge = q_and_i_total_each_campus_past_14_next_7
        formatted_hash_sh = generate_hash_for_graph 
        formatted_hash_br = generate_hash_for_graph
        historical_dates = short_hills.keys[6...21]
        historical_dates.each_with_index do |val, index|
            #take care of short hills
            formatted_hash_sh[index]["name"] = val 
            formatted_hash_sh[index]["isolation"] = short_hills[val][:isolation]
            formatted_hash_sh[index]["quarantine"] = short_hills[val][:quarantine]
            formatted_hash_sh[index]["total"] = short_hills[val].values.sum 
            # same thing with BR
            formatted_hash_br[index]["name"] = val 
            formatted_hash_br[index]["isolation"] = basking_ridge[val][:isolation]
            formatted_hash_br[index]["quarantine"] = basking_ridge[val][:quarantine]
            formatted_hash_br[index]["total"] = basking_ridge[val].values.sum 
        end
        render json: {
            shortHills: formatted_hash_sh, 
            baskingRidge: formatted_hash_br
        }
    end 

    private
    def all_details 
        short_hills, basking_ridge = q_and_i_total_each_campus_past_14_next_7
        historical_dates = short_hills.keys
        short_hills_percentages = []
        basking_ridge_percentages = []
        historical_dates.each do |d|
            current_day_total_sh = short_hills[d].values.sum 
            current_day_total_br = basking_ridge[d].values.sum 
            short_hills_percentages << ((current_day_total_sh.to_f / 364) * 100).round(2)
            basking_ridge_percentages << ((current_day_total_br.to_f / 1195) * 100).round(2)
        end 
        [short_hills_percentages, basking_ridge_percentages]
    end

    def generate_hash_for_graph 
        to_return = []
        14.times do 
            to_return << {"name" => nil, "isolation" => 0, "quarantine" => 0, "total" => 0}
        end
        to_return
    end

    def q_and_i_total_each_campus_past_14_next_7
        shortHillNumbers = generate_hash_past_14_next_7
        baskingRidgeNumbers = generate_hash_past_14_next_7
        # need to loop through each quarantine and isolation 
        shortHillNumbers.keys.each do |key|
            Quarantine.all.each do |q|
                if q.exposure + 14 > key && q.exposure <= key
                    if Student.find(q.student_id).campus == "Basking Ridge"
                        baskingRidgeNumbers[key][:quarantine] += 1
                    else 
                        shortHillNumbers[key][:quarantine] += 1
                    end 
                end 
            end 
            Isolation.all.each do |i|
                projected_end = i.end_date || (i.start_isolation + 10)
                if projected_end >= key && i.start_isolation <= key
                    if Student.find(i.student_id).campus == "Basking Ridge"
                        baskingRidgeNumbers[key][:isolation] += 1
                    else 
                        shortHillNumbers[key][:isolation] += 1
                    end 
                end 
            end
        end 
        [shortHillNumbers, baskingRidgeNumbers] 
    end
    
    def generate_hash_past_14_next_7
        counter = -13 
        to_return = {}
        while counter < 7
            to_return[Date.today + counter] = {isolation: 0, quarantine: 0}
            counter += 1
        end 
        to_return
    end

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
                addToNewQ += 1 if (((Date.today-3)..Date.today).include?(q.exposure) && !q.converted_to_isolation)
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

    # Graph that shows date and number of people out of school 
    def number_people_out_of_school 
        mapping = {Date.today => 0, Date.today + 1 => 1, Date.today + 2 => 2, Date.today + 3 => 3, Date.today + 4 => 4}
        final_hash = [{"name" => Date.today, "students" => 0, "adults" => 0, "total" => 0}, {"name" => Date.today + 1, "students" => 0, "adults" => 0, "total" => 0}, {"name" => Date.today + 2, "students" => 0, "adults" => 0, "total" => 0}, {"name" => Date.today + 3, "students" => 0, "adults" => 0, "total" => 0}, {"name" => Date.today + 4, "students" => 0, "adults" => 0, "total" => 0}]
        date_keys = final_hash.map{|obj| obj["name"]}
        date_keys.each do |key|  
            Isolation.all.each do |iso| 
                if (iso.end_date == nil && !iso.completed) ||(iso.end_date > key && !iso.completed)
                    final_hash[mapping[key]]["total"] += 1
                    if Student.find(iso.student_id).teacher 
                        final_hash[mapping[key]]["adults"] += 1
                    else 
                        final_hash[mapping[key]]["students"] += 1
                    end 
                end 
            end 
            Quarantine.all.each do |q| 
                if q.exposure + 14 > key && !q.completed
                    final_hash[mapping[key]]["total"] += 1
                    if Student.find(q.student_id).teacher 
                        final_hash[mapping[key]]["adults"] += 1
                    else
                        final_hash[mapping[key]]["students"] += 1
                    end 
                end 
            end
        end
        final_hash
    end 

end

