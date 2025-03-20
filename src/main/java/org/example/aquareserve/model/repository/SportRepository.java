package org.example.aquareserve.model.repository;

import com.fasterxml.jackson.core.type.TypeReference;
import org.example.aquareserve.model.dto.SportDTO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SportRepository implements SupabaseRepository<SportDTO> {
    final private String tableName = "sports";

    public void save(SportDTO sportDTO) throws Exception {
        System.out.println("Saving " + sportDTO);
        save(sportDTO, tableName);
    }

    public List<SportDTO> findAll() throws Exception {
        String responseJson = findAll(tableName);
        return objectMapper.readValue(responseJson, new TypeReference<>() {});
    }

    public SportDTO findById(String sportId) throws Exception {
        String responseJson = SupabaseRepository.super.findById(sportId, tableName, "sportId");
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }
}
