package org.example.aquareserve.model.repository;

import com.fasterxml.jackson.core.type.TypeReference;
import org.example.aquareserve.model.dto.MemberDTO;
import org.example.aquareserve.model.dto.ReservationDTO;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationRepository implements SupabaseRepository<ReservationDTO>{
    final private String tableName = "reservations";

    public void save(ReservationDTO reservationDTO) throws Exception {
        save(reservationDTO,  tableName);
    }

    public String findAll() throws Exception {
        String responseJson = SupabaseRepository.super.findAll(tableName);
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }

    public ReservationDTO findById(String reservationId) throws Exception {
        String responseJson = SupabaseRepository.super.findById(reservationId, tableName, "reservationId");
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }
}
