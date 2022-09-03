package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import edu.wpi.cs.dbms.repository.UserFavoriteRecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserFavoriteRecipeService {

    private final UserFavoriteRecipeRepository userFavoriteRecipeRepository;

    public List<TrendingRecipe> findTrendingRecipes(Integer page, Integer size) {
        final LocalDateTime end = LocalDateTime.now();
        final LocalDateTime start = end.minusDays(10);
        return userFavoriteRecipeRepository.findTrendingRecipes(
                start, end, PageRequest.of(page, size)
        );
    }
}
