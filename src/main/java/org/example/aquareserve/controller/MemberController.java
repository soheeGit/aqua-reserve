package org.example.aquareserve.controller;

import org.example.aquareserve.model.dto.MemberDTO;
import org.example.aquareserve.model.dto.ReservationDTO;
import org.example.aquareserve.model.repository.MemberRepository;
import org.example.aquareserve.model.repository.ReservationRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequestMapping("/")
public class MemberController {
    final private MemberRepository memberRepository;
    final private ReservationRepository reservationRepository;

    public MemberController(MemberRepository memberRepository, ReservationRepository reservationRepository) {
        this.memberRepository = memberRepository;
        this.reservationRepository = reservationRepository;
    }

    @RequestMapping("/")
    String index(Model model) throws Exception {
        model.addAttribute("members", memberRepository.findAll());
        return "index";
    }

    @GetMapping("/join")
    public String join() {
        return "join";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

//    @PostMapping(value = "/member", consumes = "application/x-www-form-urlencoded")
//    String addMemberFromForm(@ModelAttribute MemberDTO memberDTO) throws Exception {
//        System.out.println("Form-based Certifications: " + memberDTO.certifications());
//        memberRepository.save(new MemberDTO(
//                UUID.randomUUID().toString(),
//                memberDTO.name(),
//                memberDTO.email(),
//                memberDTO.password(),
//                memberDTO.phoneNumber(),
//                memberDTO.address(),
//                memberDTO.birthday(),
//                memberDTO.certifications()
//        ));
//        return "redirect:/";
//    }

    // JSON으로 받을 때 사용
    @PostMapping(value = "/member", consumes = "application/json")
    @ResponseBody
    String addMemberFromJson(@RequestBody MemberDTO memberDTO) throws Exception {
        System.out.println("JSON-based Certifications: " + memberDTO.certifications());
        memberRepository.save(new MemberDTO(
                UUID.randomUUID().toString(),
                memberDTO.name(),
                memberDTO.email(),
                memberDTO.password(),
                memberDTO.phoneNumber(),
                memberDTO.address(),
                memberDTO.birthday(),
                memberDTO.certifications()
        ));
        System.out.println("{\"success\":true,\"message\":\"회원가입이 완료되었습니다.\"}");
        return "index";
    }

    @PostMapping("/reservation")
    String addReservation(@RequestBody ReservationDTO reservationDTO) throws Exception {
        reservationRepository.save(new ReservationDTO(
                UUID.randomUUID().toString(),
                reservationDTO.memberID(),
                reservationDTO.timeslotID(),
                reservationDTO.equipmentID(),
                reservationDTO.lessonID(),
                reservationDTO.reservationDate(),
                reservationDTO.paymentAmount(),
                reservationDTO.paymentStatus()
        ));
        return "redirect:/";
    }
}
