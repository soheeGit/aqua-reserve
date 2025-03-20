package org.example.aquareserve.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import java.util.List;

public record MemberDTO(
        String memberId,
        String name,
        String email,
        String password,
        String phoneNumber,
        String address,
        String birthday,
        @JsonFormat(with = JsonFormat.Feature.ACCEPT_SINGLE_VALUE_AS_ARRAY)
        List<String> certifications
) {}