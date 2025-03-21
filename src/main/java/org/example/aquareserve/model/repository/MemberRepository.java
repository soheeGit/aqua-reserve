package org.example.aquareserve.model.repository;

import com.fasterxml.jackson.core.type.TypeReference;
import org.example.aquareserve.model.dto.MemberDTO;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Repository
public class MemberRepository implements SupabaseRepository<MemberDTO>{
    final private String tableName = "members";

    public void save(MemberDTO member) throws Exception {
        save(member, tableName);
    }

    public List<MemberDTO> findAll() throws Exception {
        String responseJson = SupabaseRepository.super.findAll(tableName);
        return objectMapper.readValue(responseJson, new TypeReference<List<MemberDTO>>() {});
    }

    public Optional<MemberDTO> findByIDPassword(String id, String password) throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("%s/%s?select=*&id=eq.%s".formatted(baseUrl, tableName, id)))
                .GET()
                .headers(
                        "apiKey", apiKey,
                        "Authorization", "Bearer %s".formatted(apiKey)
                )
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if(response.statusCode() >= 400) {
            throw  new RuntimeException(response.statusCode() + " " + response.body());
        }
        MemberDTO[] members = objectMapper.readValue(response.body(), MemberDTO[].class);
        return Arrays.stream(members)
                .filter(member -> BCrypt.checkpw(password, member.password()))
                .findFirst();
    }

    public MemberDTO findById(String memberId) throws Exception {
        String responseJson = SupabaseRepository.super.findById(memberId, tableName, "memberId");
        return objectMapper.readValue(responseJson, new TypeReference<>(){});
    }
}
