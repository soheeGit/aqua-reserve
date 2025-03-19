package org.example.aquareserve.model.dto;

public record Member(int userId, String name, String email, String password, String phoneNumber, String address, String birthday, String certifications) {
}