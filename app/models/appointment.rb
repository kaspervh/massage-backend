class Appointment < ApplicationRecord
  belongs_to :work_day

  #will figure out what days have available time for the massage duration
  def self.get_times(duration)
    work_days = get_usable_work_days()
    possible_appointments = []
    #will go through each work day
    work_days.each do |work_day|
      
      #if the work day has any appointments logic
      #otherwise the code will check how many times 
      # the duration will fit inside the open work day plus 15 minutes of preperation
      if work_day.appointments.any?
        return 'has work days'
      else
        work_day_appointments= []
        appointment_start_time = work_day.start_time
        work_day_duration_in_minutes = (work_day.end_time - work_day.start_time) /60        

        (work_day_duration_in_minutes / (duration.to_i + 15)).to_i.times do
          work_day_appointments.push({work_day_id: work_day.id, start_time: appointment_start_time, end_time: appointment_start_time + duration.to_i.minutes}) if (appointment_start_time + duration.to_i.minutes) <= work_day.end_time
          appointment_start_time = appointment_start_time + (duration.to_i + 15).minutes
        end
        possible_appointments.push(work_day_appointments)
        
      end
    end
    possible_appointments
  end

  # will get the days that are still current
  def self.get_usable_work_days
    usable_work_days = []
    work_days = WorkDay.all
    work_days.each do |work_day|
      usable_work_days.push(work_day) if work_day.start_time >= DateTime.now
    end
    usable_work_days
  end
end
