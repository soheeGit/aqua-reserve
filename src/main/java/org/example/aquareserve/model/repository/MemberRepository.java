package org.example.aquareserve.model.repository;

import com.fasterxml.jackson.core.type.TypeReference;
import org.example.aquareserve.model.dto.MemberDTO;
import org.springframework.stereotype.Repository;

import java.io.IOException;

@Repository
public class MemberRepository implements SupabaseRepository<MemberDTO>{
    final private String tableName = "members";

    public void save(MemberDTO member) throws Exception {
        save(member,  tableName);
    }

    public String findAll() throws Exception {
        String responseJson = SupabaseRepository.super.findAll(tableName);
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }

    public MemberDTO findById(String memberId) throws Exception {
        String responseJson = SupabaseRepository.super.findById(memberId, tableName, "memberId");
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }
}
