package org.example.aquareserve.model.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public record TimeslotDTO(int timeslotID, Integer facilityID, Integer sportID, LocalDate date, LocalTime startTime, LocalTime endTime, Integer maxCapacity, Integer availableSeats) {}