class Appointment < ApplicationRecord
  belongs_to :work_day

  #will figure out what days have available time for the massage duration
  def self.get_times(duration)
    #return duration.to_i
    work_days = get_usable_work_days()
    possible_appointments = []
    #will go through each work day
    work_days.each do |work_day|
      
      #if the work day has any appointments logic
      #otherwise the code will check how many times 
      # the duration will fit inside the open work day plus 30 minutes of preperation
      if work_day.appointments.any?
        new_appointments = []
        current_appointments = where(work_day_id: work_day.id)
        start_time = work_day.start_time

        current_appointments.each do |current_appointment|
          new_appointments.push(calculate_appointment_times(start_time, current_appointment.start_time, work_day, duration).flatten)
          start_time = current_appointment.end_time.to_time + 30.minutes
        end 
        new_appointments.push(calculate_appointment_times(start_time, work_day.end_time, work_day, duration))
        possible_appointments.push(new_appointments.flatten)
      else
        work_day_appointments= []
        work_day_appointments.push(calculate_appointment_times(work_day.start_time, work_day.end_time, work_day, duration ))
        possible_appointments.push(work_day_appointments.flatten)
      end
    end
    possible_appointments
  end

  def self.calculate_appointment_times(start_time, end_time, work_day, duration)
    new_appointments = []
    
    time_between_in_minutes = (end_time.to_time - start_time.to_time) /60

    (time_between_in_minutes / (duration.to_i + 30).to_i).floor.times do
      new_appointments.push({work_day_id: work_day.id, start_time: start_time, end_time: (start_time + duration.to_i.minutes)}) if (start_time + duration.to_i.minutes) <= end_time
      start_time = start_time + (duration.to_i +50).minutes
    end
    new_appointments
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
