package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
}
