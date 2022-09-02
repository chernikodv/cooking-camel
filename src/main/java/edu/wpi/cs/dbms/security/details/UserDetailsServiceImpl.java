package edu.wpi.cs.dbms.security.details;

import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final Optional<User> maybeUser = userRepository.findById(username);
        final User user = maybeUser.orElseThrow(() -> new UsernameNotFoundException("Could not find user by the given username ..."));
        return new UserDetailsImpl(user.getUsername(), user.getPassword(), user.getAdministrator());
    }
}
