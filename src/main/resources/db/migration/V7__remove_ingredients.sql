begin;

delete
from cooking_camel_schema.ingredient
where (select count(*) from cooking_camel_schema.recipe_ingredient where ingredient_id = id) = 0;

end;