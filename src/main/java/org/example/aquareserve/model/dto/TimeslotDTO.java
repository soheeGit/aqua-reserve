package org.example.aquareserve.model.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public record TimeslotDTO(
        String timeslotID,
        String facilityID,
        String sportID,
        LocalDate date,
        LocalTime startTime,
        LocalTime endTime,
        Integer maxCapacity,
        Integer availableSeats
) {}