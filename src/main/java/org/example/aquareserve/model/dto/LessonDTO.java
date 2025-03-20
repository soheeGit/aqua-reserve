package org.example.aquareserve.model.dto;

import java.math.BigDecimal;

public record LessonDTO(
        String lessonID,
        String sportID,
        String level,
        String name,
        String description,
        BigDecimal price
) {}

