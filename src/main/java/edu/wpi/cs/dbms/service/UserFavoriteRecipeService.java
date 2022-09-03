package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipe;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipeId;
import edu.wpi.cs.dbms.repository.UserFavoriteRecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserFavoriteRecipeService {

    private final UserFavoriteRecipeRepository userFavoriteRecipeRepository;

    public Page<UserFavoriteRecipe> findByUser(Integer page, Integer size, User user) {
        return userFavoriteRecipeRepository.findAllByUserOrderByLikedOnAsc(user, PageRequest.of(page, size));
    }

    public UserFavoriteRecipe save(User user, Recipe recipe) {
        final UserFavoriteRecipeId userFavoriteRecipeId = new UserFavoriteRecipeId();
        userFavoriteRecipeId.setUsername(user.getUsername());
        userFavoriteRecipeId.setRecipeId(recipe.getId());

        final UserFavoriteRecipe userFavoriteRecipe = new UserFavoriteRecipe();
        userFavoriteRecipe.setId(userFavoriteRecipeId);
        userFavoriteRecipe.setRecipe(recipe);
        userFavoriteRecipe.setUser(user);

        return userFavoriteRecipeRepository.save(userFavoriteRecipe);
    }

    public void remove(User user, Recipe recipe) {
        final UserFavoriteRecipeId userFavoriteRecipeId = new UserFavoriteRecipeId();
        userFavoriteRecipeId.setUsername(user.getUsername());
        userFavoriteRecipeId.setRecipeId(recipe.getId());

        userFavoriteRecipeRepository.deleteById(userFavoriteRecipeId);
    }

    public List<TrendingRecipe> findTrendingRecipes(Integer page, Integer size) {
        final LocalDateTime end = LocalDateTime.now();
        final LocalDateTime start = end.minusDays(10);
        return userFavoriteRecipeRepository.findTrendingRecipes(
                start, end, PageRequest.of(page, size)
        );
    }
}
