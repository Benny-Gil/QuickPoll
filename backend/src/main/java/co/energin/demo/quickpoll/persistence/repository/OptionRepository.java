package co.energin.demo.quickpoll.persistence.repository;

import co.energin.demo.quickpoll.persistence.entity.OptionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OptionRepository extends JpaRepository<OptionEntity, Long> {
}