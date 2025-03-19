package org.example.aquareserve.model.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record Reservation(int reservationID, Integer memberID, Integer timeslotID, Integer equipmentID, Integer lessonID, LocalDateTime reservationDate, BigDecimal paymentAmount, String paymentStatus) {}
