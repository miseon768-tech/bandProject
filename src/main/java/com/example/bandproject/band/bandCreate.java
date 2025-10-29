package com.example.bandproject.band;

import com.example.bandproject.model.Band;
import com.example.bandproject.model.BandMember;


public class bandCreate {

    /**
     * 새 밴드 등록 시 전달될 Band 데이터 준비
     */
    public Band createBand(String name, String description, String masterMemberId, boolean isPublic) {
        Band band = new Band();
        band.setName(name);
        band.setDescription(description);
        band.setMaster_member_id(masterMemberId);
        band.set_public(isPublic);
        band.setCreated_at(java.time.LocalDateTime.now());
        band.setUpdated_at(java.time.LocalDateTime.now());


        return band;
    }

    /**
     * 밴드 생성 후 자동으로 밴드 멤버 등록용 데이터 생성
     */
    public BandMember registerMaster(int bandNo, String memberId) {
        BandMember bm = new BandMember();
        bm.setBand_no(bandNo);
        bm.setMember_id(memberId);
        bm.setRole("MASTER");
        bm.setApproved(true);
        bm.setJoined_at(java.time.LocalDateTime.now());


        return bm;
    }

    /**
     * 콘솔 테스트용 (실제 insert 없음)
     */
    public static void main(String[] args) {
        bandCreate creator = new bandCreate();

        // 1️⃣ 밴드 생성 객체 준비
        Band band = creator.createBand("테스트 밴드", "밴드 소개 텍스트", "test_user", true);
        System.out.println("[Band 생성] " + band.getName() + " / " + band.getDescription());

        // 2️⃣ 밴드 마스터 멤버 객체 준비
        BandMember master = creator.registerMaster(1, "test_user");
        System.out.println("[BandMember 등록] 밴드번호=" + master.getBand_no() + ", 역할=" + master.getRole());
    }
}
