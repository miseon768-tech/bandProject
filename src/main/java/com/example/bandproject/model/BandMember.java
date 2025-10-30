package com.example.bandproject.model;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BandMember {

    int no;
    int band_no;
    String member_id;
    String role;
    String nickname;
    boolean approved;
    LocalDateTime joined_at;

}
