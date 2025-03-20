package org.example.aquareserve.controller;

import org.example.aquareserve.model.dto.SportDTO;
import org.example.aquareserve.model.repository.SportRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {
    final private SportRepository sportRepository;

    public AdminController(SportRepository sportRepository) {
        this.sportRepository = sportRepository;
    }

    @PostMapping("/sport")
    String addSport(@ModelAttribute SportDTO sportDTO) throws Exception {
        sportRepository.save(new SportDTO(
                UUID.randomUUID().toString(),
                sportDTO.type(),
                sportDTO.name(),
                sportDTO.description()
        ));
        return "redirect:/";
    }
}
