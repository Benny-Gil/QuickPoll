package co.energin.demo.quickpoll.persistence.repository;

import co.energin.demo.quickpoll.persistence.entity.PollEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface PollRepository extends JpaRepository<PollEntity, Long> {
    @Query("SELECT p FROM PollEntity p LEFT JOIN FETCH p.options ORDER BY p.createdAt DESC")
    List<PollEntity> findAllWithOptions();
}