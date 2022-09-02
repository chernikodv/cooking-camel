package edu.wpi.cs.dbms.security.token;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
public class AuthenticationTokenProvider {

    private static final String AUTHORIZATION_HEADER_TYPE = "Bearer";

    private final long expiration;
    private final String secretKey;

    public AuthenticationTokenProvider(@Value("${jwt.secret}") String secretKey,
                                       @Value("${jwt.expiration}") long expiration) {
        this.secretKey = secretKey;
        this.expiration = expiration;
    }

    public String generate(Authentication authentication) {
        final UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        final List<String> roles = userDetails.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList());

        return Jwts.builder()
                .setSubject(userDetails.getUsername())
                .claim("roles", roles)
                .setIssuedAt(new Date())
                .setExpiration(new Date((new Date()).getTime() + expiration))
                .signWith(SignatureAlgorithm.HS512, secretKey)
                .compact();
    }

    public String getUsername(String token) {
        return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
    }

    public boolean validate(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            log.info("JWT has not been validated ...", e);
        }

        return false;
    }

    public String parse(String header) {
        if (StringUtils.hasText(header) && header.startsWith(AUTHORIZATION_HEADER_TYPE)) {
            return header.substring(AUTHORIZATION_HEADER_TYPE.length()).trim();
        }

        return null;
    }
}
