package com.example.bandproject.model;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BandMember {

    String id;
    String name;
    String nickname;
    String role;
    boolean approved;
    LocalDateTime joined_at;

}
