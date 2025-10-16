package org.example.demo.dto;

import jakarta.validation.constraints.NotNull;
import org.example.demo.enums.DayOfWeekEnum;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class AvailabilityDTO {
    private long id;
    @NotNull(message = "the dayOfWeek is required")
    private DayOfWeekEnum dayOfWeek;
    @NotNull(message = "the start time is required")
    private LocalTime startTime;
    @NotNull(message = "the end time is required")
    private LocalTime endTime;
    private LocalDate startDate;
    private LocalDate endDate;
    private int slotDuration;
    private long UserId;
    private  boolean isAvailable;

    private String startDateFormatted;
    private String endDateFormatted;
    private String startTimeFormatted;
    private String endTimeFormatted;

    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public void setUserId(long UserId) {
        this.UserId = UserId;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public AvailabilityDTO(int slotDuration , DayOfWeekEnum dayOfWeek, LocalTime startTime, LocalTime endTime, LocalDate startDate , LocalDate endDate , long UserId) {
        this.slotDuration = slotDuration ;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.startDate = startDate;
        this.endDate = endDate;
        this.UserId = UserId;
    }



    public AvailabilityDTO(
            long id, DayOfWeekEnum dayOfWeek,LocalTime startTime, LocalTime endTime, LocalDate startDate, LocalDate endDate, int slotDuration,boolean isAvailable
    ) {
        this.id = id;
        this.dayOfWeek = dayOfWeek;
        this.slotDuration = slotDuration;
        this.startDateFormatted = startDate.format(dateFormatter);
        this.endDateFormatted  = (endDate != null ) ? endDate.format(dateFormatter)  : null;
        this.startTimeFormatted  = startTime.format(timeFormatter);
        this.endTimeFormatted  = endTime.format(timeFormatter) ;
        this.isAvailable = isAvailable;

    }

    public String getStartDateFormatted() {
        return startDateFormatted;
    }

    public void setStartDateFormatted(String startDateFormatted) {
        this.startDateFormatted = startDateFormatted;
    }

    public String getEndDateFormatted() {
        return endDateFormatted;
    }

    public void setEndDateFormatted(String endDateFormatted) {
        this.endDateFormatted = endDateFormatted;
    }

    public String getStartTimeFormatted() {
        return startTimeFormatted;
    }

    public void setStartTimeFormatted(String startTimeFormatted) {
        this.startTimeFormatted = startTimeFormatted;
    }

    public String getEndTimeFormatted() {
        return endTimeFormatted;
    }

    public void setEndTimeFormatted(String endTimeFormatted) {
        this.endTimeFormatted = endTimeFormatted;
    }

    public DateTimeFormatter getDateFormatter() {
        return dateFormatter;
    }

    public void setDateFormatter(DateTimeFormatter dateFormatter) {
        this.dateFormatter = dateFormatter;
    }

    public DateTimeFormatter getTimeFormatter() {
        return timeFormatter;
    }

    public void setTimeFormatter(DateTimeFormatter timeFormatter) {
        this.timeFormatter = timeFormatter;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getUserId() {
        return UserId;
    }

    public DayOfWeekEnum getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(DayOfWeekEnum dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public int getSlotDuration() {
        return slotDuration;
    }

    public void setSlotDuration(int slotDuration) {
        this.slotDuration = slotDuration;
    }


    @Override
    public String toString() {
        return "AvailabilityDTO{" +
                "id=" + id +
                ", dayOfWeek=" + dayOfWeek +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", slotDuration=" + slotDuration +
                ", UserId=" + UserId +
                '}';
    }
}
