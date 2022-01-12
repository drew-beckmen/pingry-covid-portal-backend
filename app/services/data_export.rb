require 'csv'
require 'pry'
class DataExport
    EXPORT_QUERY = "   
    with people as (
        select s.veracross_id,
            s.first_name,
            s.last_name,
            s.grade,
            s.id,
            s.teacher,
            s.campus
        from students s
    ),
    iso as (
        select p.*, i.start_isolation as start,
        case when i.end_date is null then i.start_isolation + 10 else i.end_date end,
        'Isolation' as Type
        from isolations i join people p on p.id = i.student_id
        where completed is false
    ),
    quar as (
        select p.*, q.exposure as start,
                case
                    when q.end_date is not null then q.end_date
                    when q.is_seven_day is true then q.exposure + 7
                    else q.exposure + 14
                end,
                'Quarantine' as Type
        from quarantines q join people p on p.id = q.student_id
        where completed is false
    )
    select * from iso
    union all
    select * from quar
    "

    def self.generate_csv
        attributes = %w{veracross_id id first_name last_name grade teacher campus start end type}
        results = ActiveRecord::Base.connection.execute(EXPORT_QUERY)
        columns = results.fields
        CSV.open(File.join(Rails.root, "app", "mailers", "covid_data_export.csv"), "w") do |csv|
            csv << columns
            results.values.each do |row|
                csv << row
            end 
        end 
    end 
end 