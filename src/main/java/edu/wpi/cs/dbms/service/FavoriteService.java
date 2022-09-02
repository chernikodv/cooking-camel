package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.repository.FavoriteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;

    public List<String> findTrendingRecipeTitles(Integer page, Integer size) {
        return favoriteRepository.groupByRecipeTitle(PageRequest.of(page, size));
    }
}
