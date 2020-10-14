class Appointment < ApplicationRecord
  belongs_to :work_day

  #will figure out what days have available time for the massage duration
  def self.get_times(duration)
    work_days = get_usable_work_days()
    
    #will go through each work day
    work_days.each do |work_day|
      
      #if the work day has any appointments logic
      #otherwise the code will check how many times 
      # the duration will fit inside the open work day plus 15 minutes of preperation
      if work_day.appointments.any?
        return 'has work days'
      else
        possible_appointments = []
        start_time = work_day.start_time
        end_time = work_day.end_time
        appointment_start_time = work_day.start_time
        work_day_duration_in_minutes = (work_day.end_time - work_day.start_time) /100
        amount_of_times = 
        

        (work_day_duration_in_minutes / (duration.to_i + 15)).to_i.times do
          possible_appointments.push({start_time: appointment_start_time, end_time: appointment_start_time + duration.to_i.minutes})
          appointment_start_time = appointment_start_time + (duration.to_i + 15).minutes
        end
        
        return possible_appointments
      end
    end
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
