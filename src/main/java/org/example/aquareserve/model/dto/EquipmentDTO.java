package org.example.aquareserve.model.dto;

import java.math.BigDecimal;

public record EquipmentDTO(String equipmentID, String type, String name, String description, BigDecimal price) {}

