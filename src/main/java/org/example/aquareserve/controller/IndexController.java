package org.example.aquareserve.controller;

import org.example.aquareserve.model.dto.MemberDTO;
import org.example.aquareserve.model.repository.MemberRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Member;

@Controller
@RequestMapping("/")
public class IndexController {
    final private MemberRepository memberRepository;

    public IndexController(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @RequestMapping("/")
    String index() {
        return "index";
    }

    @PostMapping("/member")
    String addMember(@RequestBody MemberDTO memberDTO) throws Exception {
        memberRepository.save(memberDTO);
        return "redirect:/";
    }
}
