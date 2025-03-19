package org.example.aquareserve.model.dto;

import java.math.BigDecimal;

public record Lesson(int lessonID, Integer sportID, String level, String name, String description, BigDecimal price) {}

