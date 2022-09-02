begin;

create or replace function cooking_camel_schema.insert(title text, directions text, ingredients_text text,
                                                       ingredients text[]) returns void
    language plpgsql as
$$
declare
    ingredient_text text;
    recipe_id       int;
    value           int;
begin
    insert into cooking_camel_schema.recipe
    values (default, title, directions, ingredients_text)
    on conflict do nothing
    returning id into recipe_id;
    if recipe_id is null then
        return;
    end if;
    foreach ingredient_text in array ingredients
        loop
            select id into value from cooking_camel_schema.ingredient where name = ingredient_text;
            if value is not null then
                insert into cooking_camel_schema.recipe_ingredient values (recipe_id, value) on conflict do nothing;
            end if;
        end loop;
end;
$$;

select cooking_camel_schema.insert('No-Bake Nut Cookies',
                                   '["In a heavy 2-quart saucepan, mix brown sugar, nuts, evaporated milk and butter or margarine.", "Stir over medium heat until mixture bubbles all over top.", "Boil and stir 5 minutes more. Take off heat.", "Stir in vanilla and cereal; mix well.", "Using 2 teaspoons, drop and shape into 30 clusters on wax paper.", "Let stand until firm, about 30 minutes."]',
                                   '["1 c. firmly packed brown sugar", "1/2 c. evaporated milk", "1/2 tsp. vanilla", "1/2 c. broken nuts (pecans)", "2 Tbsp. butter or margarine", "3 1/2 c. bite size shredded rice biscuits"]',
                                   ARRAY ['brown sugar', 'milk', 'vanilla', 'nuts', 'butter', 'bite size shredded rice biscuits']);
select cooking_camel_schema.insert('Jewell BallS Chicken',
                                   '["Place chipped beef on bottom of baking dish.", "Place chicken on top of beef.", "Mix soup and cream together; pour over chicken. Bake, uncovered, at 275\u00b0 for 3 hours."]',
                                   '["1 small jar chipped beef, cut up", "4 boned chicken breasts", "1 can cream of mushroom soup", "1 carton sour cream"]',
                                   ARRAY ['beef', 'chicken breasts', 'cream of mushroom soup', 'sour cream']);
select cooking_camel_schema.insert('Creamy Corn',
                                   '["In a slow cooker, combine all ingredients. Cover and cook on low for 4 hours or until heated through and cheese is melted. Stir well before serving. Yields 6 servings."]',
                                   '["2 (16 oz.) pkg. frozen corn", "1 (8 oz.) pkg. cream cheese, cubed", "1/3 c. butter, cubed", "1/2 tsp. garlic powder", "1/2 tsp. salt", "1/4 tsp. pepper"]',
                                   ARRAY ['frozen corn', 'cream cheese', 'butter', 'garlic powder', 'salt', 'pepper']);
select cooking_camel_schema.insert('Chicken Funny',
                                   '["Boil and debone chicken.", "Put bite size pieces in average size square casserole dish.", "Pour gravy and cream of mushroom soup over chicken; level.", "Make stuffing according to instructions on box (do not make too moist).", "Put stuffing on top of chicken and gravy; level.", "Sprinkle shredded cheese on top and bake at 350\u00b0 for approximately 20 minutes or until golden and bubbly."]',
                                   '["1 large whole chicken", "2 (10 1/2 oz.) cans chicken gravy", "1 (10 1/2 oz.) can cream of mushroom soup", "1 (6 oz.) box Stove Top stuffing", "4 oz. shredded cheese"]',
                                   ARRAY ['chicken', 'chicken gravy', 'cream of mushroom soup', 'shredded cheese']);
select cooking_camel_schema.insert('Reeses Cups(Candy)  ',
                                   '["Combine first four ingredients and press in 13 x 9-inch ungreased pan.", "Melt chocolate chips and spread over mixture. Refrigerate for about 20 minutes and cut into pieces before chocolate gets hard.", "Keep in refrigerator."]',
                                   '["1 c. peanut butter", "3/4 c. graham cracker crumbs", "1 c. melted butter", "1 lb. (3 1/2 c.) powdered sugar", "1 large pkg. chocolate chips"]',
                                   ARRAY ['peanut butter', 'graham cracker crumbs', 'butter', 'powdered sugar', 'chocolate chips']);
select cooking_camel_schema.insert('Cheeseburger Potato Soup',
                                   '["Wash potatoes; prick several times with a fork.", "Microwave them with a wet paper towel covering the potatoes on high for 6-8 minutes.", "The potatoes should be soft, ready to eat.", "Let them cool enough to handle.", "Cut in half lengthwise; scoop out pulp and reserve.", "Discard shells.", "Brown ground beef until done.", "Drain any grease from the meat.", "Set aside when done.", "Meat will be added later.", "Melt butter in a large kettle over low heat; add flour, stirring until smooth.", "Cook 1 minute, stirring constantly. Gradually add milk; cook over medium heat, stirring constantly, until thickened and bubbly.", "Stir in potato, ground beef, salt, pepper, 1 cup of cheese, 2 tablespoons of green onion and 1/2 cup of bacon.", "Cook until heated (do not boil).", "Stir in sour cream if desired; cook until heated (do not boil).", "Sprinkle with remaining cheese, bacon and green onions."]',
                                   '["6 baking potatoes", "1 lb. of extra lean ground beef", "2/3 c. butter or margarine", "6 c. milk", "3/4 tsp. salt", "1/2 tsp. pepper", "1 1/2 c (6 oz.) shredded Cheddar cheese, divided", "12 sliced bacon, cooked, crumbled and divided", "4 green onion, chopped and divided", "1 (8 oz.) carton sour cream (optional)"]',
                                   ARRAY ['baking potatoes', 'extra lean ground beef', 'butter', 'milk', 'salt', 'pepper', 'Cheddar cheese', 'bacon', 'green onion', 'sour cream']);
select cooking_camel_schema.insert('Rhubarb Coffee Cake',
                                   '["Cream sugar and butter.", "Add egg and beat well.", "To creamed butter, sugar and egg, add alternately buttermilk with mixture of flour, salt and soda.", "Mix well.", "Add rhubarb and vanilla.", "Pour into greased 9 x 13-inch pan and add Topping."]',
                                   '["1 1/2 c. sugar", "1/2 c. butter", "1 egg", "1 c. buttermilk", "2 c. flour", "1/2 tsp. salt", "1 tsp. soda", "1 c. buttermilk", "2 c. rhubarb, finely cut", "1 tsp. vanilla"]',
                                   ARRAY ['sugar', 'butter', 'egg', 'buttermilk', 'flour', 'salt', 'soda', 'rhubarb', 'vanilla']);
select cooking_camel_schema.insert('Scalloped Corn',
                                   '["Mix together both cans of corn, crackers, egg, 2 teaspoons of melted butter and pepper and place in a buttered baking dish.", "Dot with remaining 4 teaspoons of butter.", "Bake at 350\u00b0 for 1 hour."]',
                                   '["1 can cream-style corn", "1 can whole kernel corn", "1/2 pkg. (approximately 20) saltine crackers, crushed", "1 egg, beaten", "6 tsp. butter, divided", "pepper to taste"]',
                                   ARRAY ['cream-style corn', 'whole kernel corn', 'crackers', 'egg', 'butter', 'pepper']);
select cooking_camel_schema.insert('NolanS Pepper Steak',
                                   '["Roll steak strips in flour.", "Brown in skillet.", "Salt and pepper.", "Combine tomato liquid, water, onions and browned steak. Cover and simmer for one and a quarter hours.", "Uncover and stir in Worcestershire sauce.", "Add tomatoes, green peppers and simmer for 5 minutes.", "Serve over hot cooked rice."]',
                                   '["1 1/2 lb. round steak (1-inch thick), cut into strips", "1 can drained tomatoes, cut up (save liquid)", "1 3/4 c. water", "1/2 c. onions", "1 1/2 Tbsp. Worcestershire sauce", "2 green peppers, diced", "1/4 c. oil"]',
                                   ARRAY ['tomatoes', 'water', 'onions', 'Worcestershire sauce', 'green peppers', 'oil']);
select cooking_camel_schema.insert('Millionaire Pie',
                                   '["Empty Cool Whip into a bowl.", "Drain juice from pineapple.", "Mix Cool Whip and pineapple.", "Add condensed milk.", "Squeeze lemons, remove seeds and add to Cool Whip and pineapple.", "Chop nuts into small pieces and add to mixture.", "Stir all ingredients together and mix well.", "Pour into a graham cracker crust.", "Use top from crust to cover top of pie.", "Chill overnight.", "Makes 2 pies."]',
                                   '["1 large container Cool Whip", "1 large can crushed pineapple", "1 can condensed milk", "3 lemons", "1 c. pecans", "2 graham cracker crusts"]',
                                   ARRAY ['pineapple', 'condensed milk', 'lemons', 'pecans', 'graham cracker crusts']);
select cooking_camel_schema.insert('Double Cherry Delight',
                                   '["Drain cherries, measuring syrup.", "Cut cherries in half.", "Add ginger ale and enough water to syrup to make 1 1/2 cups.", "Dissolve gelatin in boiling water.", "Add measured liquid and almond extract. Chill until very thick.", "Fold in marshmallows and the cherries. Spoon into 6-cup mold.", "Chill until firm, at least 4 hours or overnight.", "Unmold.", "Makes about 5 1/3 cups."]',
                                   '["1 (17 oz.) can dark sweet pitted cherries", "1/2 c. ginger ale", "1 (6 oz.) pkg. Jell-O cherry flavor gelatin", "2 c. boiling water", "1/8 tsp. almond extract", "1 c. miniature marshmallows"]',
                                   ARRAY ['dark sweet pitted cherries', 'ginger ale', 'flavor gelatin', 'boiling water', 'almond extract', 'marshmallows']);
select cooking_camel_schema.insert('Buckeye Candy',
                                   '["Mix sugar, butter and peanut butter.", "Roll into balls and place on cookie sheet.", "Set in freezer for at least 30 minutes. Melt chocolate chips and paraffin in double boiler.", "Using a toothpick, dip balls 3/4 of way into chocolate chip and paraffin mixture to make them look like buckeyes."]',
                                   '["1 box powdered sugar", "8 oz. soft butter", "1 (8 oz.) peanut butter", "paraffin", "12 oz. chocolate chips"]',
                                   ARRAY ['powdered sugar', 'butter', 'peanut butter', 'paraffin', 'chocolate chips']);
select cooking_camel_schema.insert('Quick Barbecue Wings',
                                   '["Clean wings.", "Flour and fry until done.", "Place fried chicken wings in microwave bowl.", "Stir in barbecue sauce.", "Microwave on High (stir once) for 4 minutes."]',
                                   '["chicken wings (as many as you need for dinner)", "flour", "barbecue sauce (your choice)"]',
                                   ARRAY ['chicken', 'flour', 'barbecue sauce']);
select cooking_camel_schema.insert('Taco Salad Chip Dip',
                                   '["Mix taco sauce, sour cream and cream cheese.", "Spread on pizza pan.", "Brown meat.", "Drain off fat and add taco seasoning.", "Spread over cream mixture.", "Layer with raw vegetables.", "Top with cheese. Serve with chips."]',
                                   '["8 oz. Ortega taco sauce", "8 oz. sour cream", "8 oz. cream cheese", "1 lb. ground beef", "1 pkg. taco seasoning", "shredded lettuce", "1 large diced tomato", "1 medium diced onion", "1 large diced green pepper", "shredded Colby or Cheddar cheese"]',
                                   ARRAY ['taco sauce', 'sour cream', 'cream cheese', 'ground beef', 'taco seasoning', 'shredded lettuce', 'tomato', 'onion', 'green pepper', 'Cheddar cheese']);
select cooking_camel_schema.insert('Pink Stuff(Frozen Dessert)  ',
                                   '["Mix all ingredients together.", "Pour into a 9 x 13-inch pan. Freeze until firm.", "Allow to set out approximately 15 minutes before serving."]',
                                   '["1 can pie filling (cherry or strawberry)", "1 can crushed pineapple, drained", "1 can sweetened condensed milk", "1 (8 oz.) container thawed whipped topping", "2 Tbsp. lemon juice"]',
                                   ARRAY ['pie filling', 'pineapple', 'condensed milk', 'lemon juice']);
select cooking_camel_schema.insert('Fresh Strawberry Pie',
                                   '["Mix water, cornstarch, sugar and salt in saucepan.", "Stir constantly and boil until thick and clear.", "Remove from heat and stir in jello.", "Set aside to cool.", "But dont allow it to set. Layer strawberries in baked crust.", "Pour cooled glaze over. Continue layering berries and glaze.", "Refrigerate.", "Serve with whipped cream."]',
                                   '["1 baked pie shell", "1 qt. cleaned strawberries", "1 1/2 c. water", "4 Tbsp. cornstarch", "1 c. sugar", "1/8 tsp. salt", "4 Tbsp. strawberry jello"]',
                                   ARRAY ['shell', 'cleaned strawberries', 'water', 'cornstarch', 'sugar', 'salt', 'strawberry jello']);
select cooking_camel_schema.insert('Easy German Chocolate Cake',
                                   '["Mix according to directions and add oil.", "Bake in 9 x 13-inch pan."]',
                                   '["1/2 pkg. chocolate fudge cake mix without pudding or 1 Jiffy mix", "1/2 pkg. white cake mix without pudding or 1 Jiffy mix", "1/4 c. Wesson oil"]',
                                   ARRAY ['chocolate fudge cake', 'white cake', 'Wesson oil']);
select cooking_camel_schema.insert('Broccoli Salad',
                                   '["Trim off large leaves of broccoli and remove the tough ends of lower stalks. Wash the broccoli thoroughly. Cut the florets and stems into bite-size pieces. Place in a large bowl. Add bacon, onions and raisins. Combine remaining ingredients, stirring well. Add dressing to broccoli mixture and toss gently. Cover and refrigerate 2 to 3 hours. Makes about 6 servings."]',
                                   '["1 large head broccoli (about 1 1/2 lb.)", "10 slices bacon, cooked and crumbled", "5 green onions, sliced or 1/4 c. chopped red onion", "1/2 c. raisins", "1 c. mayonnaise", "2 Tbsp. vinegar", "1/4 c. sugar"]',
                                   ARRAY ['broccoli', 'bacon', 'green onions', 'raisins', 'mayonnaise', 'vinegar', 'sugar']);
select cooking_camel_schema.insert('Strawberry Whatever',
                                   '["Mix Jell-O in boiling water.", "Add strawberries, pineapple, crushed bananas and nuts.", "Spread 1/2 mixture in 13 x 6 1/2-inch pan.", "Allow to gel in freezer 30 minutes.", "Add layer of sour cream, then remaining mixture on top.", "Gel and serve."]',
                                   '["1 lb. frozen strawberries in juice", "1 small can crushed pineapple", "3 ripe bananas", "1 c. chopped pecans", "1 large pkg. strawberry Jell-O", "1 1/2 c. boiling water", "1 pt. sour cream"]',
                                   ARRAY ['frozen strawberries', 'pineapple', 'bananas', 'pecans', 'strawberry', 'boiling water', 'sour cream']);
select cooking_camel_schema.insert('Eggless Milkless Applesauce Cake',
                                   '["Mix Crisco with applesauce, nuts and raisins.", "Sift dry ingredients and add.", "Mix well.", "Put in a greased and floured loaf pan or tube pan.", "Bake in loaf pan at 350\u00b0 to 375\u00b0 for 45 to 60 minutes, layer pan at 375\u00b0 for 20 minutes or tube pan at 325\u00b0 for 1 hour."]',
                                   '["3/4 c. sugar", "1/2 c. shortening", "1 1/2 c. applesauce", "3 level tsp. soda", "1 tsp. each: cinnamon, cloves and nutmeg", "2 c. sifted flour", "1 c. raisins", "1 c. nuts"]',
                                   ARRAY ['sugar', 'shortening', 'applesauce', 'soda', 'cinnamon', 'flour', 'raisins', 'nuts']);
select cooking_camel_schema.insert('Grandma HanrathS Banana Breadfort Collins, Colorado  ',
                                   '["Cream sugar and shortening.", "Add eggs, salt and soda, then bananas and flour.", "Add nuts.", "Mix well.", "Bake in loaf pan at 350\u00b0 for 1 hour."]',
                                   '["1 c. sugar", "1/2 c. shortening", "2 eggs (add one at a time)", "1 tsp. salt", "2 tsp. soda", "2 c. flour", "1/4 c. nuts", "2 over-ripe bananas (chopped)"]',
                                   ARRAY ['sugar', 'shortening', 'eggs', 'salt', 'soda', 'flour', 'nuts', 'bananas']);
select cooking_camel_schema.insert('Chocolate Frango Mints',
                                   '["Mix ingredients together for 5 minutes.", "Scrape bowl often. Last fold in chocolate chip mints.", "Bake at 350\u00b0 for 35 to 40 minutes or until done (cake mix directions)."]',
                                   '["1 pkg. devils food cake mix", "1 pkg. chocolate fudge pudding mix (instant)", "8 oz. sour cream", "3/4 c. water", "1/2 c. Wesson oil", "4 eggs", "6 oz. chopped Frango mints"]',
                                   ARRAY ['cake mix', 'chocolate fudge pudding', 'sour cream', 'water', 'Wesson oil', 'eggs', 'Frango']);
select cooking_camel_schema.insert('Cuddy Farms Marinated Turkey',
                                   '["Buy whole turkey breast; remove all skin and bones. Cut into pieces about the size of your hand. Pour marinade over turkey and refrigerate for at least 8 hours (up to 48 hours). The longer it marinates, the less cooking time it takes."]',
                                   '["2 c. 7-Up or Sprite", "1 c. vegetable oil", "1 c. Kikkoman soy sauce", "garlic salt"]',
                                   ARRAY ['vegetable oil', 'soy sauce', 'garlic']);
select cooking_camel_schema.insert('Spaghetti Sauce To Can',
                                   '["Cook ground or chopped peppers and onions in oil for 1/2 hour. Cook tomatoes and garlic as for juice.", "Put through the mill.", "(I use a food processor and do my tomatoes uncooked.", "I then add the garlic right to the juice.)", "Add peppers and onions to juice and remainder of ingredients.", "Cook approximately 1 hour.", "Put in jars and seal.", "Yields 7 quarts."]',
                                   '["1/2 bushel tomatoes", "1 c. oil", "1/4 c. minced garlic", "6 cans tomato paste", "3 peppers (2 sweet and 1 hot)", "1 1/2 c. sugar", "1/2 c. salt", "1 Tbsp. sweet basil", "2 Tbsp. oregano", "1 tsp. Italian seasoning"]',
                                   ARRAY ['tomatoes', 'oil', 'garlic', 'tomato paste', 'peppers', 'sugar', 'salt', 'sweet basil', 'oregano', 'Italian seasoning']);
select cooking_camel_schema.insert('Prize-Winning Meat Loaf',
                                   '["Mix well.", "Press firmly into an 8 1/2 x 4 1/2 x 2 1/2-inch loaf pan.", "Bake in preheated moderate oven.", "Bake at 350\u00b0 for 1 hour.", "Let stand 5 minutes before slicing.", "Makes 8 servings."]',
                                   '["1 1/2 lb. ground beef", "1 c. tomato juice", "3/4 c. oats (uncooked)", "1 egg, beaten", "1/4 c. chopped onion", "1/4 tsp. pepper", "1 1/2 tsp. salt"]',
                                   ARRAY ['ground beef', 'tomato juice', 'oats', 'egg', 'onion', 'pepper', 'salt']);
select cooking_camel_schema.insert('Smothered Round Steak(Servings: 4)  ',
                                   '["Alex Patout says, \"Smothering is a multipurpose Cajun technique that works wonders with everything from game to snap beans.", "Its similar to what the rest of the world knows as braising.", "The ingredients are briefly browned or sauteed, then cooked with a little liquid over a low heat for a long time.\""]',
                                   '["2 lb. round steak", "1/2 tsp. ground black pepper", "1 tsp. ground white pepper", "1/2 c. vegetable oil", "2 bell peppers, chopped", "1 c. beef stock or water", "2 tsp. salt", "1 tsp. ground red pepper", "all-purpose flour (dredging)", "3 medium onions, chopped", "1 celery rib, chopped"]',
                                   ARRAY ['steak', 'ground black pepper', 'ground white pepper', 'vegetable oil', 'bell peppers', 'beef stock', 'salt', 'ground red pepper', 'flour', 'onions', 'celery']);
select cooking_camel_schema.insert('Corral Barbecued Beef Steak Strips',
                                   '["Brown strips in cooking oil.", "Pour off drippings.", "Combine tomato sauce, water, brown sugar, mustard and Worcestershire sauce.", "Add sauce and onion to meat slices.", "Cover and cook slowly, stirring occasionally 30 minutes or until meat is tender. Serve over rice or buttered noodles.", "Yields 6 to 8 servings."]',
                                   '["2 lb. round steak 1/2 to 3/4-inch thick, sliced in strips 1/8-inch thick (or thinner) and 3 1/2 to 4-inches long (easily sliced if partially frozen)", "2 Tbsp. cooking oil", "1 can (15 oz.) tomato sauce", "1/3 c. water", "2 Tbsp. brown sugar", "1 Tbsp. prepared mustard", "1 tbsp. Worcestershire sauce", "1 medium sized onion, thinly sliced"]',
                                   ARRAY ['long', 'cooking oil', 'tomato sauce', 'water', 'brown sugar', 'mustard', 'Worcestershire sauce', 'onion']);
select cooking_camel_schema.insert('Easy Fudge',
                                   '["Butter a square pan, 8 x 8 x 2-inches.", "Heat milk, chocolate chips and unsweetened chocolate over low heat, stirring constantly, until chocolate is melted and mixture is smooth. Remove from heat.", "Stir in nuts and vanilla.", "Spread in pan."]',
                                   '["1 (14 oz.) can sweetened condensed milk", "1 (12 oz.) pkg. semi-sweet chocolate chips", "1 (1 oz.) sq. unsweetened chocolate (if desired)", "1 1/2 c. chopped nuts (if desired)", "1 tsp. vanilla"]',
                                   ARRAY ['condensed milk', 'semi-sweet chocolate chips', 'unsweetened chocolate', 'nuts', 'vanilla']);
select cooking_camel_schema.insert('Taco-Filled Green Pepper',
                                   '["In a large skillet, brown the ground beef. Drain, stir in taco mix, kidney beans, and salsa. Bring to a boil. Reduce heat, and let simmer for about 5 minutes. Cut peppers in half and clean it. Put peppers in boiling water for 3 minutes- drain- spoon the meat mixture into the green pepper. Put pepper in an ungreased pan. Cover, and bake at 350 degrees for 15 to 20 minutes or until peppers are crispy and filling is heated through. Top with tomatoes, cheese, and sour cream."]',
                                   '["1 lb. Ground Beef", "1 pkg. taco seasoning", "1 san Kidney beans", "1 onion, chopped", "1 C salsa", "4 green peppers", "1 medium Tomato, chopped", "1/2 C cheddar cheese, shredded", "1/2 C sour cream"]',
                                   ARRAY ['Ground Beef', 'taco seasoning', 'beans', 'onion', 'salsa', 'green peppers', 'Tomato', 'cheddar cheese', 'sour cream']);
select cooking_camel_schema.insert('One Hour Rolls',
                                   '["Put flour into a large mixing bowl.", "Combine sugar, milk, salt and oil in a saucepan and heat to boiling; remove from heat and let cool to lukewarm.", "Add yeast and mix well.", "Pour into flour and stir.", "Batter will be sticky.", "Roll out batter on a floured board and cut with biscuit cutter.", "Lightly brush tops with melted oleo and fold over.", "Place rolls on a cookie sheet, put in a warm place and let rise for 1 hour.", "Bake at 350\u00b0 for about 20 minutes. Yield: 2 1/2 dozen."]',
                                   '["1 c. milk", "2 Tbsp. sugar", "1 pkg. dry yeast", "1 Tbsp. salt", "3 Tbsp. Crisco oil", "2 c. plain flour"]',
                                   ARRAY ['milk', 'sugar', 'yeast', 'salt', 'Crisco oil', 'flour']);
select cooking_camel_schema.insert('Punch Bowl Fruit Salad',
                                   '["In a 6-quart punch bowl mix all of the cans of fruit, juice and all.", "Clean and slice berries.", "Wash and slice apples; leave peeling on apples.", "Dice apples.", "Slice bananas.", "Wash and cut grapes in half.", "Mix all together.", "Nuts or other fruit may be added."]',
                                   '["2 large cans sliced peaches", "2 large cans fruit cocktail", "1 large can diced pineapple", "1 qt. fresh strawberries", "2 red apples", "2 yellow apples", "4 large ripe bananas", "1 lb. white grapes", "1 lb. purple grapes"]',
                                   ARRAY ['peaches', 'fruit cocktail', 'pineapple', 'fresh strawberries', 'red apples', 'yellow apples', 'bananas', 'white grapes', 'purple grapes']);
select cooking_camel_schema.insert('Summer Chicken', '["Double recipe for more chicken."]',
                                   '["1 pkg. chicken cutlets", "1/2 c. oil", "1/3 c. red vinegar", "2 Tbsp. oregano", "2 Tbsp. garlic salt"]',
                                   ARRAY ['chicken cutlets', 'oil', 'red vinegar', 'oregano', 'garlic salt']);
select cooking_camel_schema.insert('Cherry Pizza',
                                   '["Grease a 9 x 12-inch cake pan.", "Spread cherry pie mix.", "Sift cake mix and spread it dry over the cherries.", "Top with ground nuts.", "Melt butter and pour over top.", "Bake 45 minutes in a 350\u00b0 oven."]',
                                   '["2 cans cherry pie mix", "1 box deluxe white cake mix", "1 stick butter", "1 c. ground nuts"]',
                                   ARRAY ['cherry pie mix', 'deluxe white cake mix', 'butter', 'ground nuts']);
select cooking_camel_schema.insert('Potato And Cheese Pie',
                                   '["Beat eggs, salt and pepper until well blended.", "Stir in half and half, potatoes and onions.", "Pour into well-greased 8-inch baking dish.", "Bake in a 400\u00b0 oven for 35 to 40 minutes, or until knife inserted in center comes out clean and potatoes are tender. Cool on rack 5 minutes; cut into squares.", "Makes 4 large servings."]',
                                   '["3 eggs", "1 tsp. salt", "1/4 tsp. pepper", "2 c. half and half", "3 c. potatoes, shredded coarse", "1 c. Cheddar cheese, coarsely shredded", "1/3 c. green onions"]',
                                   ARRAY ['eggs', 'salt', 'pepper', 'potatoes', 'Cheddar cheese', 'green onions']);
select cooking_camel_schema.insert('Tuna Macaroni Casserole',
                                   '["Prepare macaroni and cheese as directed.", "Add drained tuna, pimento and onion.", "Mix.", "Serve hot or cold."]',
                                   '["1 box macaroni and cheese", "1 can tuna, drained", "1 small jar pimentos", "1 medium onion, chopped"]',
                                   ARRAY ['macaroni', 'tuna', 'pimentos', 'onion']);
select cooking_camel_schema.insert('Broccoli Dip For Crackers',
                                   '["Mix together sour cream, soup mix, broccoli and half of cheese.", "Sprinkle remaining cheese on top.", "Bake at 350\u00b0 for 30 minutes, uncovered.", "Serve hot with vegetable crackers."]',
                                   '["16 oz. sour cream", "1 pkg. dry vegetable soup mix", "10 oz. pkg. frozen chopped broccoli, thawed and drained", "4 to 6 oz. Cheddar cheese, grated"]',
                                   ARRAY ['sour cream', 'vegetable soup mix', 'broccoli', 'Cheddar cheese']);
select cooking_camel_schema.insert('Summer Spaghetti',
                                   '["Prepare spaghetti per package.", "Drain.", "Melt a little butter through it.", "Marinate overnight in Salad Supreme and Zesty Italian dressing.", "Just before serving, add cucumbers, tomatoes, green peppers, mushrooms, olives or whatever your taste may want."]',
                                   '["1 lb. very thin spaghetti", "1/2 bottle McCormick Salad Supreme (seasoning)", "1 bottle Zesty Italian dressing"]',
                                   ARRAY ['Salad Supreme', 'Italian dressing']);
select cooking_camel_schema.insert('Pear-Lime Salad',
                                   '["Drain pears, reserving juice.", "Bring juice to a boil, stirring constantly.", "Remove from heat.", "Add gelatin, stirring until dissolved.", "Let cool slightly.", "Coarsely chop pear halves. Combine cream cheese and yogurt; beat at medium speed of electric mixer until smooth.", "Add gelatin and beat well.", "Stir in pears.", "Pour into an oiled 4-cup mold or Pyrex dish.", "Chill."]',
                                   '["1 (16 oz.) can pear halves, undrained", "1 (3 oz.) pkg. lime gelatin", "1 (8 oz.) pkg. cream cheese, softened", "1 (8 oz.) carton lemon yogurt"]',
                                   ARRAY ['pear halves', 'lime gelatin', 'cream cheese', 'lemon yogurt']);
select cooking_camel_schema.insert('Watermelon Rind Pickles',
                                   '["Trim off green and pink parts of watermelon rind; cut to 1-inch cubes.", "Parboil until tender, but not soft.", "Drain. Combine sugar, vinegar, oil of cloves and oil of cinnamon; bring to boiling and pour over rind.", "Let stand overnight.", "In the morning, drain off syrup.", "Heat and put over rind.", "The third morning, heat rind and syrup; seal in hot, sterilized jars.", "Makes 8 pints.", "(Oil of cinnamon and clove keeps rind clear and transparent.)"]',
                                   '["7 lb. watermelon rind", "7 c. sugar", "2 c. apple vinegar", "1/2 tsp. oil of cloves", "1/2 tsp. oil of cinnamon"]',
                                   ARRAY ['watermelon rind', 'sugar', 'apple vinegar', 'oil', 'oil of cinnamon']);
select cooking_camel_schema.insert('Chicken Stew',
                                   '["Remove chicken from bone.", "Use the broth.", "Mix the vegetables and macaroni.", "Add sugar, salt and black pepper.", "Cook until all vegetables are tender over medium heat."]',
                                   '["3 lb. chicken, boiled", "4 medium potatoes, diced", "2 medium onions, chopped", "1 (16 oz.) can creamed corn", "1 (16 oz.) can English peas", "1 (16 oz.) can field peas", "1 (16 oz.) can butter beans", "1 (16 oz.) can tomatoes", "1 (46 oz.) can tomato juice", "1 small box macaroni", "1 Tbsp. black pepper", "1 Tbsp. salt", "1 Tbsp. sugar"]',
                                   ARRAY ['chicken', 'potatoes', 'onions', 'corn', 'English peas', 'peas', 'butter beans', 'tomatoes', 'tomato juice', 'macaroni', 'black pepper', 'salt', 'sugar']);
select cooking_camel_schema.insert('Quick Coffee Cake(6 Servings)  ',
                                   '["Mix 3 tablespoons fat with granulated sugar.", "Add egg and beat until creamy.", "Mix flour, baking powder and salt thoroughly.", "Add to sugar mixture alternately with milk.", "Add vanilla. Spread batter evenly in a greased 8-inch square baking pan.", "Mix brown sugar and cinnamon and sprinkle over batter.", "Dot with 2 tablespoons fat.", "Bake at 350\u00b0 (moderate oven) for 25 to 30 minutes."]',
                                   '["3 Tbsp. softened butter or margarine", "1/2 c. granulated sugar", "1 egg", "1 c. flour", "1 1/4 tsp. baking powder", "1/4 tsp. salt", "1/3 c. milk", "1/4 tsp. vanilla", "1/3 c. brown sugar, packed", "1/2 tsp. cinnamon", "2 Tbsp. butter or margarine"]',
                                   ARRAY ['butter', 'sugar', 'egg', 'flour', 'baking powder', 'salt', 'milk', 'vanilla', 'brown sugar', 'cinnamon']);
select cooking_camel_schema.insert('Angel Biscuits',
                                   '["Mix flour, sugar, baking powder, soda and salt together.", "Cut in margarine, dissolve yeast in warm water.", "Stir into buttermilk and add to dry mixture.", "Cover and chill."]',
                                   '["5 c. flour", "3 Tbsp. sugar", "4 tsp. baking powder", "1 1/2 pkg. dry yeast", "2 c. buttermilk", "1 tsp. soda", "1 1/2 sticks margarine", "1/2 c. warm water"]',
                                   ARRAY ['flour', 'sugar', 'baking powder', 'yeast', 'buttermilk', 'soda', 'margarine', 'warm water']);
select cooking_camel_schema.insert('Quick Peppermint Puffs',
                                   '["Dip marshmallows in melted margarine; roll in candy. Wrap a crescent triangle around each marshmallow, completely covering the marshmallow and square edges of dough tightly to seal.", "Dip in margarine and place in a greased muffin tin.", "Bake at 375\u00b0 for 10 to 15 minutes; remove from pan."]',
                                   '["8 marshmallows", "2 Tbsp. margarine, melted", "1/4 c. crushed peppermint candy", "1 can crescent rolls"]',
                                   ARRAY ['marshmallows', 'margarine', 'peppermint candy', 'crescent rolls']);
select cooking_camel_schema.insert('Chocolate Mint Bars',
                                   '["Mix together and bake in 9 x 13-inch pan at 350\u00b0 for 25 to 30 minutes.", "Top should spring back when touched lightly; do not overbake.", "Cool completely, then spread with mint layer."]',
                                   '["1 c. flour", "1 c. sugar", "1/2 c. oleo, softened", "4 eggs", "1 can chocolate syrup"]',
                                   ARRAY ['flour', 'sugar', 'oleo', 'eggs', 'chocolate syrup']);
select cooking_camel_schema.insert('Beer Bread',
                                   '["Stir the ingredients together and put in a greased and floured loaf pan.", "Bake at 425 degrees for 50 minutes.", "Drizzle melted butter on top."]',
                                   '["3 c. self rising flour", "1 - 12 oz. can beer", "1 Tbsp. sugar"]',
                                   ARRAY ['flour', 'beer', 'sugar']);
select cooking_camel_schema.insert('Chicken Divan',
                                   '["Melt margarine in skillet; saute onions and celery.", "Remove from heat.", "Stir in flour and curry powder.", "Drain mushrooms and keep juice.", "Add water to juice to make 1/2 cup liquid.", "Stir liquid and soup into flour mixture; add mushrooms.", "Cook until thick.", "Arrange broccoli and cubed chicken in a large baking dish. Spoon sauce over chicken.", "Top with grated cheese.", "Bake in a 350\u00b0 oven for about 20 minutes or in microwave until cheese is melted."]',
                                   '["1/4 c. margarine", "1/4 c. chopped onion (or as much as you want)", "chopped celery to taste", "1/4 c. flour", "1/8 tsp. curry powder", "1 can sliced mushrooms (save juice)", "1 can cream of celery soup", "1 pkg. chopped broccoli", "1 cubed chicken", "shredded Monterey Jack cheese"]',
                                   ARRAY ['margarine', 'onion', 'celery', 'flour', 'curry powder', 'mushrooms', 'cream of celery soup', 'broccoli', 'chicken', 'cheese']);
select cooking_camel_schema.insert('Mexican Cookie Rings',
                                   '["Sift flour, baking powder and salt together.", "Cream together butter and sugar.", "Add egg yolks and vanilla.", "Beat until light and fluffy.", "Mix in sifted dry ingredients.", "Shape into 1-inch balls.", "Push wooden spoon handle through center (twist).", "Shape into rings.", "Dip each cookie into candies.", "Place on lightly greased baking sheets.", "Bake in 375\u00b0 oven for 10 to 12 minutes or until golden brown.", "Cool on racks.", "Serves 2 dozen."]',
                                   '["1 1/2 c. sifted flour", "1/2 tsp. baking powder", "1/2 tsp. salt", "1/2 c. butter", "2/3 c. sugar", "3 egg yolks", "1 tsp. vanilla", "multi-colored candies"]',
                                   ARRAY ['flour', 'baking powder', 'salt', 'butter', 'sugar', 'egg yolks', 'vanilla', 'multi-colored candies']);
select cooking_camel_schema.insert('Vegetable-Burger Soup',
                                   '["Lightly brown beef in soup pot.", "Drain off excess fat.", "Stir in tomatoes, tomato sauce, water, frozen vegetables, soup mix and sugar.", "Bring to a boil.", "Reduce heat and simmer for 20 minutes. Serve."]',
                                   '["1/2 lb. ground beef", "2 c. water", "1 tsp. sugar", "1 pkg. Cup-a-Soup onion soup mix (dry)", "1 lb. can stewed tomatoes", "1 (8 oz.) can tomato sauce", "1 (10 oz.) pkg. frozen mixed vegetables"]',
                                   ARRAY ['ground beef', 'water', 'sugar', 'onion soup', 'tomatoes', 'tomato sauce', 'frozen mixed vegetables']);
select cooking_camel_schema.insert('Chicken Ole',
                                   '["Dice chicken.", "Mix all ingredients together.", "Let sit overnight.", "Bake 1 1/2 hours at 375\u00b0."]',
                                   '["4 chicken breasts, cooked", "1 can cream of chicken soup", "1 can cream of mushroom soup", "1 can green chili salsa sauce", "1 can green chilies", "1 c. milk", "1 grated onion", "1 pkg. corn tortilla in pieces"]',
                                   ARRAY ['chicken breasts', 'cream of chicken soup', 'cream of mushroom soup', 'green chili salsa sauce', 'green chilies', 'milk', 'onion', 'corn tortilla']);
select cooking_camel_schema.insert('Creamy Coleslaw(Better Homes And Gardens)  ',
                                   '["In a large bowl, combine cabbage, carrot, green pepper and onion or can use package of slaw mix purchased from store."]',
                                   '["4 c. shredded cabbage", "1/2 c. shredded carrots", "1/4 c. finely chopped green pepper", "2 Tbsp. finely chopped onion", "1/2 c. mayonnaise", "1 Tbsp. vinegar", "2 tsp. sugar", "1 tsp. celery seed", "1/4 tsp. salt"]',
                                   ARRAY ['cabbage', 'carrots', 'green pepper', 'onion', 'mayonnaise', 'vinegar', 'sugar', 'celery', 'salt']);
select cooking_camel_schema.insert('Creole Flounder',
                                   '["Heat oven to 500\u00b0.", "Place fillets in single layer in baking dish, 13 1/2 x 9 x 2-inch.", "Stir together remaining ingredients except pepper rings. Spoon over fillets.", "Bake 5 to 8 minutes or until fish flakes easily with fork.", "Remove fillets to warm platter. Garnish with green pepper rings. Makes 4 to 6 servings."]',
                                   '["2 lb. flounder or pollack fillets", "1 1/2 c. chopped tomatoes", "1/2 c. chopped green pepper", "1/3 c. lemon juice", "1 Tbsp. salad oil", "2 tsp. salt", "2 tsp. minced onion", "1 tsp. basil leaves", "1/4 tsp. coarsely ground black pepper", "4 drops red pepper sauce", "green pepper rings"]',
                                   ARRAY ['flounder', 'tomatoes', 'green pepper', 'lemon juice', 'salad oil', 'salt', 'onion', 'basil', 'ground black pepper', 'drops red pepper sauce', 'green pepper']);
select cooking_camel_schema.insert('Three Bean Salad',
                                   '["Mix together all of sugar, salad oil, vinegar and water until sugar is dissolved.", "Pour over beans and let stand overnight."]',
                                   '["1 can green beans, wash and drain", "1 can yellow beans, wash and drain", "1 can kidney beans, wash and drain", "1 c. sugar", "1/2 c. salad oil", "2/3 c. vinegar", "1/3 c. water"]',
                                   ARRAY ['green beans', 'yellow beans', 'kidney beans', 'sugar', 'salad oil', 'vinegar', 'water']);
select cooking_camel_schema.insert('DaveS Corn Casserole',
                                   '["In a bowl, mix corns, sour cream, corn bread mix and melted margarine.", "Pour into a greased 8 x 8 x 2-inch pan.", "Bake at 350\u00b0 for 50 minutes."]',
                                   '["1 (16 1/2 oz.) can whole kernel corn, drained", "1 (16 1/2 oz.) can cream-style corn", "1 (8 oz.) sour cream", "1 (8 1/2 oz.) pkg. Jiffy corn bread mix", "1 stick margarine"]',
                                   ARRAY ['whole kernel corn', 'cream-style', 'sour cream', 'corn bread', 'margarine']);
select cooking_camel_schema.insert('Casserole Italiano',
                                   '["Brown beef with onion and seasonings and combine in a 1 1/2-quart casserole with soup, water and noodles.", "Place cheese around edges.", "Bake at 350\u00b0 for 30 minutes."]',
                                   '["1 lb. ground beef", "1/3 c. chopped onion", "1 can tomato soup", "2 c. cooked wide noodles", "1/2 tsp. oregano", "1/2 tsp. salt", "1/3 c. water", "1 c. cheese"]',
                                   ARRAY ['ground beef', 'onion', 'tomato soup', 'noodles', 'oregano', 'salt', 'water', 'cheese']);
select cooking_camel_schema.insert('Corned Beef And Cabbage Casserole',
                                   '["Combine all ingredients and cook uncovered over low heat until cabbage is crisp-tender, about 20 minutes."]',
                                   '["1 small cabbage, shredded", "1 tsp. dry mustard", "1 can corned beef, flaked", "1 can cream of celery soup", "1 medium chopped onion"]',
                                   ARRAY ['cabbage', 'dry mustard', 'corned beef', 'cream of celery soup', 'onion']);
select cooking_camel_schema.insert('Crab Cakes',
                                   '["Mix together and carefully add 1 pound lump crab meat.", "Mix ahead of time and refrigerate so they will hold together better."]',
                                   '["1 Tbsp. Worcestershire sauce", "2 or 3 shakes Old Bay", "1 tsp. dry mustard", "2 Tbsp. mayonnaise", "1 egg"]',
                                   ARRAY ['Worcestershire sauce', 'dry mustard', 'mayonnaise', 'egg']);
select cooking_camel_schema.insert('Bonbon Cookies',
                                   '["Cream together the butter and peanut butter.", "Add the remaining ingredients.", "Mix and form into balls (best to mix with your hands) and chill several hours, even a day."]',
                                   '["1/2 lb. soft butter", "1/2 c. peanut butter", "1/2 lb. graham cracker crumbs", "2 c. coconut", "1/2 c. nut meats (optional)", "dash of vanilla"]',
                                   ARRAY ['butter', 'peanut butter', 'graham cracker crumbs', 'coconut', 'nut meats', 'vanilla']);
select cooking_camel_schema.insert('Forever Amber',
                                   '["Mix together.", "Spread in a buttered pan.", "Bake for 30 minutes at 275\u00b0.", "While still hot, sift 1 box of powdered sugar into it. Drop by teaspoons on waxed paper.", "Let dry.", "If it seems set on bottom, turn over and let it continue to dry."]',
                                   '["1 lb. orange sliced candy, chopped", "2 cans Angel Flake coconut", "2 c. chopped pecans", "2 cans condensed milk", "1 tsp. vanilla", "1 tsp. orange flavoring"]',
                                   ARRAY ['orange sliced candy', 'Angel', 'pecans', 'condensed milk', 'vanilla', 'orange flavoring']);
select cooking_camel_schema.insert('Gooey Coffee Cake',
                                   '["Mix together cake mix, 2 eggs and melted oleo.", "Put in greased 9 x 13-inch pan.", "Put chopped nuts on top of mixture.", "Mix together 2 eggs, cream cheese and powdered sugar.", "Add on top of first mixture.", "Bake 15 minutes at 325\u00b0, then bake 20 minutes at 350\u00b0."]',
                                   '["1 yellow cake mix", "2 eggs", "1 stick oleo, melted", "1 c. chopped nuts", "2 eggs", "8 oz. softened cream cheese", "1 lb. powdered sugar"]',
                                   ARRAY ['yellow cake', 'eggs', 'oleo', 'nuts', 'eggs', 'cream cheese', 'powdered sugar']);
select cooking_camel_schema.insert('Phylis Pineapple-Banana Salad',
                                   '["Drain pineapple and reserve juice.", "Cut bananas in chunks like pineapple."]',
                                   '["1 large can chunk pineapple", "4 to 5 bananas"]', ARRAY ['pineapple', 'bananas']);
select cooking_camel_schema.insert('Pineapple Nut Pie',
                                   '["Cream the cream cheese; add the milk and beat smooth.", "Add lemon juice, pineapple and nuts.", "Beat well.", "Pour into graham cracker crust and chill.", "Slice in small servings (very rich) and top with dollop of Cool Whip."]',
                                   '["1 (8 oz.) pkg. cream cheese", "1 can sweetened condensed milk", "1/2 c. crushed pineapple", "1/3 c. chopped nuts", "1/3 c. lemon juice"]',
                                   ARRAY ['cream cheese', 'condensed milk', 'pineapple', 'nuts', 'lemon juice']);
select cooking_camel_schema.insert('AnnieS Diabetic Candy',
                                   '["Mix all ingredients, form in small balls and roll in chopped peanuts.", "Keep refrigerated."]',
                                   '["1 (8 oz.) Jell-O sugar-free vanilla or French vanilla pudding (put in dry)", "1 (8 oz.) Philadelphia light cream cheese", "2 Tbsp. butter", "2 Tbsp. peanut butter or more if you would like"]',
                                   ARRAY ['vanilla', 'cream cheese', 'butter', 'peanut butter']);
select cooking_camel_schema.insert('Frozen Peach Mousse',
                                   '["Puree peaches in a blender.", "Add remaining ingredients.", "Blend and pour in container and freeze."]',
                                   '["4 medium peaches, peeled and chopped", "1 to 1 1/4 c. sugar", "1 1/4 c. sour cream (use light)", "1/4 c. lemon juice", "3/4 to 1 tsp. vanilla"]',
                                   ARRAY ['peaches', 'sugar', 'sour cream', 'lemon juice', 'vanilla']);
select cooking_camel_schema.insert('Strawberry Pie', '["*Can also use blueberries or cherries."]',
                                   '["16 oz. Cool Whip", "2 pkg. frozen strawberries *", "2 (9-inch) deep pan pie crusts", "1 3/4 c. sugar", "12 oz. cream cheese"]',
                                   ARRAY ['frozen strawberries', 'sugar', 'cream cheese']);
select cooking_camel_schema.insert('Blueberry Surprise',
                                   '["Mix ingredients and press 2/3 mixture in bottom of square baking dish.", "(A bowl that has the same diameter top and bottom may be used, 1 1/2 to 2-quart size.)"]',
                                   '["1 stick margarine", "1 1/2 c. graham cracker crumbs", "1/4 c. granulated sugar"]',
                                   ARRAY ['margarine', 'graham cracker crumbs', 'granulated sugar']);
select cooking_camel_schema.insert('Moist DevilS Food Cake',
                                   '["Sift together the flour, soda and salt; set aside.", "Combine shortening and sugar in a bowl.", "Beat until creamy.", "Add egg yolks; beat well.", "Combine cocoa, water and vanilla to make 1 cup; mix well.", "Add to batter.", "Add flour mixture alternately with milk.", "Beat well after each addition; set aside.", "Beat egg whites until stiff peaks form when beater is lifted.", "Fold into batter. Bake in two 9-inch greased cake pans at 375\u00b0 for 30 minutes."]',
                                   '["2 c. sifted flour", "1 1/2 tsp. baking soda", "1/4 tsp. salt", "1/2 c. shortening", "1 1/2 c. sugar", "2 eggs, separated", "1/2 c. cocoa", "water", "1 tsp. vanilla", "1 c. milk"]',
                                   ARRAY ['flour', 'baking soda', 'salt', 'shortening', 'sugar', 'eggs', 'cocoa', 'water', 'vanilla', 'milk']);
select cooking_camel_schema.insert('DotS Civil War Cake',
                                   '["Combine and cook first 6 ingredients.", "Bring to boil and boil 5 minutes; cool.", "Add sifted, dry ingredients to apple mixture. Stir and blend only.", "Add nuts.", "Pour into greased and floured tube pan.", "Bake 1 hour at 350\u00b0.", "Serves 16."]',
                                   '["3 medium apples, chopped", "2 c. raisins", "1 c. brown sugar", "1 c. granulated sugar", "2 Tbsp. shortening", "2 c. cold water", "3 c. flour", "2 tsp. soda", "1 tsp. cinnamon", "1 tsp. nutmeg", "1 tsp. cloves", "1 tsp. salt", "1 c. nuts"]',
                                   ARRAY ['apples', 'raisins', 'brown sugar', 'sugar', 'shortening', 'cold water', 'flour', 'soda', 'cinnamon', 'nutmeg', 'cloves', 'salt', 'nuts']);
select cooking_camel_schema.insert('Potato Casserole',
                                   '["Peel and dice potatoes; place in bowl of cold, salted water. Drain potatoes and dry on paper towels.", "Mix 1/2 cup butter, onions, soup, sour cream and cheese; stir well.", "Add potatoes to mixture and pour into a 2 1/2-quart casserole dish.", "Crush cornflakes, mix with remaining butter.", "Sprinkle cornflakes and butter on top of potato mixture.", "Bake at 350\u00b0 for 50 minutes."]',
                                   '["6 c. diced potatoes", "1/2 c. chopped onion", "3/4 c. melted butter", "1 can cream of chicken soup", "1 (8 oz.) sour cream", "1 c. grated Cheddar cheese", "2 c. crushed cornflakes"]',
                                   ARRAY ['potatoes', 'onion', 'butter', 'cream of chicken soup', 'sour cream', 'Cheddar cheese', 'cornflakes']);
select cooking_camel_schema.insert('Dream Pie', '["Mix vanilla wafer crumbs with butter."]',
                                   '["vanilla wafers", "butter"]', ARRAY ['vanilla wafers', 'butter']);
select cooking_camel_schema.insert('Divinity Fudge',
                                   '["Stir well together the sugar, syrup and water.", "Allow to boil without stirring until it forms a hard ball in cold water.", "Pour this over stiffly beaten egg whites, beating constantly.", "Cool; add vanilla and nuts.", "Beat until cool and thick enough to set. Pour into a buttered platter or drop by teaspoons on waxed paper."]',
                                   '["2 2/3 c. sugar", "2/3 c. white corn syrup (Karo)", "2/3 c. cold water", "2 egg whites", "1 tsp. vanilla", "1 c. chopped nuts"]',
                                   ARRAY ['sugar', 'white corn syrup', 'cold water', 'egg whites', 'vanilla', 'nuts']);
select cooking_camel_schema.insert('Apple Crisp',
                                   '["Mix 1/2 cup of sugar and cinnamon.", "Spread on apples.", "Mix 1/4 cup sugar, flour, salt, cornflake crumbs and oleo.", "Spread mixture on apples."]',
                                   '["apples", "1/2 c. sugar", "1 tsp. cinnamon", "1/4 c. sugar", "1 c. flour", "dash of salt", "1/2 c. corn flake crumbs", "1 stick oleo"]',
                                   ARRAY ['apples', 'sugar', 'cinnamon', 'sugar', 'flour', 'salt', 'corn flake crumbs', 'oleo']);
select cooking_camel_schema.insert('Sausage Balls',
                                   '["Mix sausage and cheese together.", "Add Bisquick and mix thoroughly.", "Roll into medium size balls.", "Bake at 350\u00b0 for 15 minutes or until golden brown."]',
                                   '["2 c. Bisquick", "1 lb. sausage", "8 oz. pkg. Cheddar cheese, grated"]',
                                   ARRAY ['Bisquick', 'sausage', 'Cheddar cheese']);
select cooking_camel_schema.insert('Consomme Chicken',
                                   '["Add enough liquid to chicken soup and consomme to make 4 cups of water.", "Season with salt and pepper.", "Cook at 350\u00b0 for 1 hour."]',
                                   '["chicken parts", "1 can cream of chicken soup", "1 can consomme", "2 c. rice", "salt to taste", "pepper to taste"]',
                                   ARRAY ['chicken', 'cream of chicken soup', 'consomme', 'rice', 'salt', 'pepper']);
select cooking_camel_schema.insert('Spanish Hamburgers',
                                   '["Brown celery, onions and ground beef in butter.", "Add vinegar, lemon juice, brown sugar, mustard, salt, pepper catsup and water. Simmer for 30 minutes."]',
                                   '["1/2 c. celery", "2 chopped onions", "2 Tbsp. butter", "1 lb. ground beef", "2 Tbsp. vinegar", "2 Tbsp. lemon juice", "2 Tbsp. brown sugar", "1 1/2 Tbsp. mustard", "1 tsp. salt", "1 1/2 tsp. pepper", "1 c. catsup", "1 c. water"]',
                                   ARRAY ['celery', 'onions', 'butter', 'ground beef', 'vinegar', 'lemon juice', 'brown sugar', 'mustard', 'salt', 'pepper', 'catsup', 'water']);
select cooking_camel_schema.insert('Egg Drop Soup',
                                   '["In saucepan slowly stir the chicken broth into cornstarch. Cook, stirring constantly, until slightly thickened.", "Slowly pour in the well beaten egg; stir once gently.", "Remove from heat. Garnish with sliced green onion.", "Makes 4 servings."]',
                                   '["2 (13 3/4 oz.) cans chicken broth", "1 Tbsp. cornstarch", "1 well beaten egg", "2 Tbsp. sliced (1/4-inch) green onion"]',
                                   ARRAY ['chicken broth', 'cornstarch', 'egg', 'green onion']);
select cooking_camel_schema.insert('Mulled Cider',
                                   '["Simmer all of the ingredients.", "Strain into warmed mugs and top", "with", "a", "dash of nutmeg.", "This recipe can be doubled many times, according to the number of guests present."]',
                                   '["1/2 gal. apple juice", "1 tsp. allspice", "1 tsp. whole cloves", "1 cinnamon stick", "1 c. brown sugar"]',
                                   ARRAY ['apple juice', 'allspice', 'whole cloves', 'cinnamon', 'brown sugar']);
select cooking_camel_schema.insert('Sesame Ginger Chicken',
                                   '["Combine first 4 ingredients in a small bowl, stir well and set aside.", "Place chicken between 2 sheets of waxed paper or heavy duty plastic wrap, and flatten to 1/4-inch thickness, using meat mallet or rolling pin.", "Coat grill rack with cooking spray; place on grill over coals.", "Place chicken on rack and cook 4 minutes on each side, basting frequently with soy sauce mixture.", "Transfer chicken to a serving platter and garnish with green onion, if desired.", "Yields 4 servings, about 200 calories."]',
                                   '["1 Tbsp. sesame seed, toasted", "2 tsp. grated ginger", "2 Tbsp. honey", "2 Tbsp. reduced-sodium soy sauce", "4 (4 oz.) skinned chicken breast halves", "vegetable cooking spray", "thin green onion strips"]',
                                   ARRAY ['sesame seed', 'grated ginger', 'honey', 'soy sauce', 'chicken', 'vegetable cooking spray', 'thin green onion strips']);
select cooking_camel_schema.insert('Egg Casserole',
                                   '["Saute together first 5\tingredients.", "In a separate 9 x 12-inch pan, mix bread, eggs", "and", "milk.", "Put", "pieces of bread into", "pan; add your", "vegetables,", "then", "your", "eggs.", "Place\tin refrigerator overnight (at least 8 hours).\tAdd Cheddar cheese before cooking.", "Bake at 350\u00b0 for 1 hour."]',
                                   '["1 Vidalia onion, chopped", "1 (16 oz.) pkg. fresh mushrooms", "2 green peppers", "1 clove garlic", "olive oil", "6 pieces bread (buttered with either butter or margarine)", "6 eggs", "milk (as much as you would like; to fluff eggs)"]',
                                   ARRAY ['Vidalia onion', 'fresh mushrooms', 'green peppers', 'clove garlic', 'olive oil', 'bread', 'eggs', 'milk']);
select cooking_camel_schema.insert('Cranberry-Apple-Orange Salad',
                                   '["In food processor or blender, grind cranberries, apple and orange.", "Mix with sugar and set aside.", "Prepare gelatin according to package directions, using 1/4 cup less of cold water.", "Chill until it begins to thicken.", "Add cranberry mixture and nuts.", "Mix well.", "Pour into a mold, if desired, or leave in a bowl and stir before serving.", "Chill until set.", "Can even be made a day ahead. Keeps well in refrigerator for a few days."]',
                                   '["1 (12 oz.) bag raw cranberries (2 c.)", "1 c. sugar", "1 medium apple, peeled, cored and cut into wedges", "1 orange, peeled, seeded and broken in wedges", "1 (3 oz.) pkg. orange gelatin", "1/2 c. nuts (optional)"]',
                                   ARRAY ['cranberries', 'sugar', 'apple', 'orange', 'orange gelatin', 'nuts']);
select cooking_camel_schema.insert('Brown Rice', '["Put in a covered 1 1/2-quart dish.", "Bake 1 hour at 350\u00b0."]',
                                   '["1 c. raw rice", "1 can beef consomme", "1 can French onion soup", "1 (4 oz.) can mushrooms", "1/2 stick margarine, cut up"]',
                                   ARRAY ['rice', 'beef consomme', 'onion soup', 'mushrooms', 'margarine']);
select cooking_camel_schema.insert('Cranberry Salad',
                                   '["Mix cream cheese, margarine and sugar.", "Add fruit and walnuts. Whip cream and fold into fruit and cream cheese mixture.", "Pour into round mold.", "Freeze 6 hours.", "Remove from mold shortly before serving.", "Makes 12 servings."]',
                                   '["2 (3 oz.) pkg. softened cream cheese", "2 Tbsp. margarine", "2 Tbsp. sugar", "1 (16 oz.) can whole berry cranberry sauce", "3/4 c. crushed pineapple, drained", "1/2 c. chopped walnuts", "1 c. whipping cream"]',
                                   ARRAY ['cream cheese', 'margarine', 'sugar', 'cranberry sauce', 'pineapple', 'walnuts', 'whipping cream']);
select cooking_camel_schema.insert('Cheese Dip',
                                   '["Dice tomatoes and peppers.", "Combine all ingredients in top of double boiler for 30 minutes.", "Serve hot over corn chips."]',
                                   '["2 lb. Velveeta cheese", "1 (15 oz.) can Italian tomatoes", "2 small cans green chili peppers", "1/2 medium onion, minced", "3 cloves garlic", "1/2 tsp. salt"]',
                                   ARRAY ['Velveeta cheese', 'Italian tomatoes', 'green chili peppers', 'onion', 'garlic', 'salt']);
select cooking_camel_schema.insert('Funnel Cake',
                                   '["Sift first 5 ingredients together in a bowl.", "Mix egg and milk together; add to dry ingredients.", "Beat until smooth.", "Hold finger over bottom of a funnel; pour in some batter.", "Remove finger to let batter drop.", "Drop batter in a spiral motion into pan filled with 1 inch of hot oil (375\u00b0).", "Fry until golden brown, turning once.", "Remove from pan; drain on a paper towel.", "Sprinkle with powdered sugar and serve hot."]',
                                   '["1 1/3 c. flour", "1 1/4 tsp. salt", "1/2 tsp. soda", "2 Tbsp. sugar", "3/4 Tbsp. baking powder", "1 egg, beaten", "2/3 c. milk (more if batter is too thick)", "oil (for frying)", "powdered sugar"]',
                                   ARRAY ['flour', 'salt', 'soda', 'sugar', 'baking powder', 'egg', 'milk', 'oil', 'powdered sugar']);
select cooking_camel_schema.insert('Fast Real Good Fudge',
                                   '["In large bowl, put confectioners sugar, cocoa and chopped nuts.", "In saucepan, put margarine and Velveeta.", "Melt and add vanilla.", "Pour hot mixture over sugar mixture.", "Mix quickly and pour into buttered cookie sheet.", "Cool and cut into squares."]',
                                   '["4 lb. confectioners sugar", "1 c. cocoa", "1 c. chopped nuts", "1 lb. margarine (not whipped)", "1 lb. Velveeta", "1 Tbsp. vanilla"]',
                                   ARRAY ['confectioners sugar', 'cocoa', 'nuts', 'margarine', 'Velveeta', 'vanilla']);
select cooking_camel_schema.insert('Squash Casserole',
                                   '["Cook squash, onions and carrots until tender.", "Mash.", "Melt butter in pan; stir in stuffing until all is coated.", "Drain all water from squash.", "Stir in sour cream and soup.", "Place in a greased baking dish a layer of squash and a layer of stuffing. Bake at 350\u00b0 for 35 minutes."]',
                                   '["3 lb. squash", "3 onions", "1 pt. sour cream", "3 carrots, grated", "2 cans chicken or mushroom soup", "1 pkg. Pepperidge Farm stuffing mix", "1 stick butter", "salt and pepper to taste"]',
                                   ARRAY ['squash', 'onions', 'sour cream', 'carrots', 'chicken', 'stuffing mix', 'butter', 'salt']);
select cooking_camel_schema.insert('Cheese Ball',
                                   '["Combine softened cream and Cheddar cheeses.", "Add chopped up items.", "Mix and add liquids last.", "Mix well.", "Roll into ball and cover with chopped nuts."]',
                                   '["2 pkg. cream cheese", "2 c. shredded Cheddar cheese (8 oz.)", "1 Tbsp. chopped pimento", "1 Tbsp. chopped green pepper", "1 Tbsp. chopped onion", "1 tsp. lemon juice", "2 tsp. Worcestershire sauce", "dash of Tabasco sauce", "dash of salt"]',
                                   ARRAY ['cream cheese', 'Cheddar cheese', 'pimento', 'green pepper', 'onion', 'lemon juice', 'Worcestershire sauce', 'Tabasco sauce', 'salt']);
select cooking_camel_schema.insert('*Apricot Salad',
                                   '["Dissolve jello in boiling water; add sugar.", "Blend in the cream cheese with a fork.", "Add can of crushed pineapple and apricot baby food.", "Refrigerate.", "Chill can of milk.", "When jello starts to set, take milk out of the refrigerator and beat until stiff.", "Fold partially set jello into cream.", "Chopped nuts can be used for garnish.", "This is a large salad; could fill a 2-quart mold or 2 (1-quart) molds.", "Serves about 12."]',
                                   '["1 large pkg. apricot jello (6 oz.)", "2/3 c. sugar", "1 (8 oz.) pkg. cream cheese", "2 jars Junior baby food apricots", "1 (No. 2) can crushed pineapple (20 oz.)", "1 tall can evaporated milk, chilled and whipped", "2/3 c. water"]',
                                   ARRAY ['apricot jello', 'sugar', 'cream cheese', 'jars Junior baby food', 'pineapple', 'milk', 'water']);
select cooking_camel_schema.insert('Pound Cake',
                                   '["Have all ingredients at room temperature. Hand stir all dry ingredients together. Add eggs and stir. Add butter and Crisco and stir. Add milk and stir. Put batter in", "mixer and beat at high speed until well blended. Add 1 to 2 teaspoons of your favorite flavoring and mix well. Pour batter into greased and floured tube pan. Place in cold oven. Bake at 325\u00b0 for 1 hour and 20 to 30 minutes."]',
                                   '["3 c. plain flour (cake flour may be substituted for plain flour)", "3 c. sugar", "1/2 tsp. baking powder", "3 dashes of salt", "5 eggs", "2 sticks margarine", "1/2 c. butter flavor Crisco", "1 c. sweet milk", "1 to 2 Tbsp. flavoring (lemon, vanilla or almond or a combination of the 3)"]',
                                   ARRAY ['flour', 'sugar', 'baking powder', 'salt', 'eggs', 'margarine', 'butter', 'sweet milk', 'vanilla']);
select cooking_camel_schema.insert('Monkey Bread',
                                   '["Use greased 9 x 13-inch pan or Bundt pan.", "Melt butter; add brown sugar, pudding, milk and cinnamon.", "Break up 1 loaf into round balls; place in pan.", "Pour mixture over and break second loaf over this.", "Rise 2 1/2 to 3 hours.", "Bake 30 minutes at 350\u00b0; turn out immediately to cool."]',
                                   '["2 loaves frozen bread, softened", "1/2 c. margarine", "1 c. brown sugar", "1 large box vanilla pudding (not instant)", "2 Tbsp. milk", "cinnamon to taste"]',
                                   ARRAY ['bread', 'margarine', 'brown sugar', 'vanilla pudding', 'milk', 'cinnamon']);
select cooking_camel_schema.insert('Chicken Roll-Ups',
                                   '["Unroll crescent rolls; add cooked chicken and grated cheese. Wrap roll over chicken and cheese; pinch sides together."]',
                                   '["1 (8 oz.) can crescent rolls", "1 1/2 c. grated medium or sharp cheese", "1 hen, cooked and diced", "1 can cream of chicken soup", "1 1/2 c. milk"]',
                                   ARRAY ['crescent rolls', 'cheese', 'hen', 'cream of chicken soup', 'milk']);
select cooking_camel_schema.insert('Beef And Spanish Rice Casserole',
                                   '["Spray a 1-quart casserole dish with Pam.", "Layer rice and meat, diced onion and grated cheese.", "Bake at 350\u00b0 for 25 to 30 minutes."]',
                                   '["1 can Spanish rice", "1 can corned beef", "1 diced onion", "1/2 c. grated Cheddar cheese"]',
                                   ARRAY ['Spanish rice', 'corned beef', 'onion', 'Cheddar cheese']);
select cooking_camel_schema.insert('Baked Beans',
                                   '["Cook onions and bell pepper in oil until onions are transparent.", "Add beef and cook until brown.", "Mix all ingredients together.", "Bake in 350\u00b0 oven for 45 minutes, or after mixing together, pour in crock-pot and cook 6 to 10 hours on low."]',
                                   '["3 (1 lb.) cans pork and beans", "1/2 c. bell pepper, chopped", "1/2 c. onions, chopped", "3/4 c. catsup", "1/3 c. brown sugar, packed hard", "1 tsp. salt", "1/3 tsp. black pepper", "1 lb. ground beef", "1 Tbsp. oil"]',
                                   ARRAY ['pork', 'bell pepper', 'onions', 'catsup', 'brown sugar', 'salt', 'black pepper', 'ground beef', 'oil']);
select cooking_camel_schema.insert('Sweet-N-Sour Chicken',
                                   '["Saute onion in 2 tablespoons shortening.", "Add carrots, water and bouillon cubes.", "Simmer 5 minutes.", "Combine next 6 ingredients.", "Add to vegetable mixture and cook until clear.", "Add pepper, pineapple and chicken.", "Cover and simmer 5 minutes or until heated through.", "Serve with rice or angel hair noodles. Serves 6 people."]',
                                   '["2 c. diced cooked chicken", "2 Tbsp. shortening", "1/2 c. onion (large chunks)", "2 c. carrot chunks", "1 1/4 c. water", "3 chicken bouillon cubes", "1/4 c. packed brown sugar", "2 Tbsp. cornstarch", "1/4 tsp. ginger", "1/4 c. catsup", "2 Tbsp. vinegar", "1 Tbsp. soy sauce", "1 c. green pepper (large chunks)", "8 oz. pineapple chunks"]',
                                   ARRAY ['chicken', 'shortening', 'onion', 'carrot chunks', 'water', 'chicken', 'brown sugar', 'cornstarch', 'ginger', 'catsup', 'vinegar', 'soy sauce', 'green pepper', 'pineapple']);
select cooking_camel_schema.insert('Ambrosia',
                                   '["Combine all ingredients. Chill overnight.", "Yields 4 to 6 servings."]',
                                   '["8 to 10 juicy oranges, peeled and diced", "1 c. moist coconut", "1/2 c. pecans, chopped", "1/2 c. cherries, halved", "1/4 c. sugar", "1 c. orange juice"]',
                                   ARRAY ['oranges', 'moist coconut', 'pecans', 'cherries', 'sugar', 'orange juice']);
select cooking_camel_schema.insert('Crazy Peanut Butter Cookies',
                                   '["Mix together and roll into balls; flatten with fork.", "Bake on ungreased cookie sheet.", "Makes 2 dozen.", "Quick, easy and good."]',
                                   '["1 c. creamy peanut butter", "1 c. sugar", "1 egg"]',
                                   ARRAY ['peanut butter', 'sugar', 'egg']);
select cooking_camel_schema.insert('Brickle Bars',
                                   '["Mix together with a fork:", "cake mix, 1 egg and margarine. Press into a 13 x 9-inch pan.", "Next mix Eagle Brand milk, 1 egg, pecans and Bits O Brickle.", "Pour over cake mixture.", "Bake 30 minutes at 350\u00b0.", "Let cool and cut into bars."]',
                                   '["1 box yellow cake mix", "2 eggs", "1/3 c. soft margarine", "1 can Eagle Brand milk", "1 c. pecans", "1/2 c. Bits O Brickle"]',
                                   ARRAY ['yellow cake mix', 'eggs', 'margarine', 'milk', 'pecans']);
select cooking_camel_schema.insert('Pancakes',
                                   '["Mix dry ingredients.", "Add egg, margarine and buttermilk. Stir by hand until well blended.", "Pour onto non-stick pan or griddle with a little oil added.", "Cook until bubbly and turn over."]',
                                   '["1 c. flour", "1 tsp. soda", "1 tsp. salt", "1 Tbsp. sugar", "1 egg", "3 Tbsp. margarine, melted", "1 c. buttermilk"]',
                                   ARRAY ['flour', 'soda', 'salt', 'sugar', 'egg', 'margarine', 'buttermilk']);
select cooking_camel_schema.insert('Crustless Vegetable Ham Pie',
                                   '["Preheat oven to 325\u00b0.", "In large frying pan, melt butter and saute mushrooms, garlic, onion and zucchini until tender, approximately 2 minutes.", "Add ham and cook 1 more minute; set aside."]',
                                   '["1/4 c. butter", "1/4 lb. mushrooms, sliced", "1 garlic clove, minced", "1 medium zucchini, sliced thinly", "1/4 c. chopped onion", "1 c. diced, cooked ham", "4 eggs", "2 c. Ricotta cheese", "1 c. shredded Monterey Jack", "1 (10 oz.) pkg. frozen spinach, thawed and drained", "1/2 tsp. dill weed", "salt and pepper"]',
                                   ARRAY ['butter', 'mushrooms', 'garlic', 'zucchini', 'onion', 'eggs', 'Ricotta cheese', 'shredded Monterey Jack', 'frozen spinach', 'dill weed', 'salt']);
select cooking_camel_schema.insert('Red Cabbage And Apples',
                                   '["In a saucepan filled with lightly salted boiling water, cook red cabbage for 5 minutes; then drain."]',
                                   '["1 c. red cabbage, finely chopped", "2 Tbsp. butter", "2 apples, finely sliced", "1 Tbsp. brown sugar", "1 Tbsp. vinegar"]',
                                   ARRAY ['red cabbage', 'butter', 'apples', 'brown sugar', 'vinegar']);
select cooking_camel_schema.insert('JanS Winter Soup',
                                   '["Saute onions and garlic in butter until onions are tender. Add meat and brown. Drain well. Add the rest of the ingredients and simmer at least one hour."]',
                                   '["2 Tbsp. butter", "2 medium onions, chopped", "1 lb. ground beef or turkey", "1 clove garlic, minced", "3 c. beef or chicken broth", "1 (28 oz.) can tomatoes, chopped", "1 c. diced potatoes", "3 carrots, chopped", "1 c. celery, chopped", "1 c. frozen green beans", "1 c. dry red wine", "1/2 tsp. basil", "1/4 tsp. thyme", "salt and pepper to taste"]',
                                   ARRAY ['butter', 'onions', 'ground beef', 'clove garlic', 'beef', 'tomatoes', 'potatoes', 'carrots', 'celery', 'frozen green beans', 'red wine', 'basil', 'thyme', 'salt']);
select cooking_camel_schema.insert('Microwave Spice Tea',
                                   '["Mix all ingredients together and store in airtight container. When ready to serve, heat 1 cup water in microwave until boiling. Add 3 heaping teaspoons.", "Mix to water and stir well.", "Great for winter cold and to get the chill out."]',
                                   '["1 (1 lb. 2 oz.) jar Tang", "1 pkg. lemonade Kool Aid with sugar added", "2 c. sugar", "1 tsp. ground cloves", "2 tsp. cinnamon", "1/2 c. instant tea"]',
                                   ARRAY ['sugar', 'sugar', 'ground cloves', 'cinnamon', 'instant tea']);
select cooking_camel_schema.insert('Barbecue Noodle Cheese Bake',
                                   '["Cook hamburg and crumble.", "Add Manwich.", "Spray Pam in baking dish.", "Layer 1/2 of noodles, then 1/2 hamburg mixture on noodles. Put enough cheese slices on to cover meat.", "Layer all again.", "Bake for 1/2 hour at 350\u00b0."]',
                                   '["1 can Manwich", "1 lb. hamburg", "American cheese slices", "noodles, cooked and drained"]',
                                   ARRAY ['Manwich', 'hamburg', 'American cheese', 'noodles']);
select cooking_camel_schema.insert('Cutout Cookie',
                                   '["Mix all ingredients.", "Chill for several hours.", "Cut out with cookie cutters.", "Bake at 350\u00b0 for 10 minutes.", "Frost if you want to. Makes approximately 4 dozen."]',
                                   '["1/2 c. shortening", "1/2 c. butter", "1 c. sugar", "2 eggs, beaten", "1 1/2 tsp. vanilla", "2 1/2 c. flour", "1 tsp. baking powder", "1/2 tsp. salt"]',
                                   ARRAY ['shortening', 'butter', 'sugar', 'eggs', 'vanilla', 'flour', 'baking powder', 'salt']);
select cooking_camel_schema.insert('Don JuanS Sangria',
                                   '["Squeeze the juice of lime, orange and apple in a large pitcher; add 1/2 cup sugar and fruit pieces.", "Pour in the wine, brandy and Triple Sec and stir with a long handled spoon until well mixed.", "Taste.", "If you prefer the sangria sweeter, add up to 1/4 cup more sugar."]',
                                   '["1 lime, cut into wedges", "1 orange, cut into slices", "1/2 large apple, cut into thin wedges", "1/2 to 3/4 c. sugar", "1 bottle dry red Spanish wine", "1/4 c. brandy", "1/4 c. Triple Sec", "club soda"]',
                                   ARRAY ['lime', 'orange', 'apple', 'sugar', 'red Spanish', 'brandy', 'Triple Sec', 'club soda']);
select cooking_camel_schema.insert('Ranch Beef And Beans',
                                   '["Combine all ingredients in large pot; simmer 30-45 minutes or until onion and bell peppers become soft.", "This recipe triples and freezes well.", "Serve with cornbread."]',
                                   '["1 lb. cooked, crumbled hamburger (drained)", "1 c. onion, chopped", "1 c. kidney beans, cooked and drained", "1 c. butter beans", "1 c. baked beans", "3/4 c. ketchup", "1 sm. can mild green chilies, chopped (opt.)", "1 TBSP prepared mustard", "1 tsp. beef bouillon", "1/2 c. water", "2 TBSP. honey", "2/3 c. bell pepper, chopped", "1 tsp. Worcestershire sauce", "1/2 tsp. garlic pwd"]',
                                   ARRAY ['hamburger', 'onion', 'kidney beans', 'butter beans', 'beans', 'ketchup', 'green chilies', 'mustard', 'beef bouillon', 'water', 'honey', 'bell pepper', 'Worcestershire sauce', 'garlic']);
select cooking_camel_schema.insert('Crisp Oatmeal Cookies',
                                   '["Mix oats, brown sugar and oil; let stand overnight or 8 hours. Preheat oven to 325\u00b0.", "Mix rest of ingredients into oat mixture. Drop by teaspoon onto greased baking sheet.", "Bake 15 minutes. Cool completely before removing from baking sheet."]',
                                   '["4 c. quick cooking oats", "2 c. brown sugar, packed", "1 c. salad oil", "2 eggs, well beaten", "1/2 tsp. salt", "1 tsp. almond extract"]',
                                   ARRAY ['cooking oats', 'brown sugar', 'salad oil', 'eggs', 'salt', 'almond extract']);
select cooking_camel_schema.insert('Souper Tuna Crunch',
                                   '["Reserve 1/2 cup Chinese noodles.", "In 1 1/2-quart casserole, combine remaining noodles, soup, water, tuna, cashews, celery, onion and peas.", "Bake at 350\u00b0 for 30 minutes or until hot.", "Stir; sprinkle reserved noodles around edge.", "Bake 5 minutes more. Serve with soy sauce.", "Makes about 4 1/2 cups."]',
                                   '["1 can Chinese noodles", "1 can Campbells cream of mushroom soup", "3/4 c. water", "1 (6 1/2 oz.) can Chicken of the Sea tuna, drained and broken in chunks", "1 c. cashews or peanuts", "1 c. chopped celery", "1/2 c. finely chopped onion", "1/2 c. cooked peas", "soy sauce"]',
                                   ARRAY ['Chinese noodles', 'Campbells cream', 'water', 'Chicken', 'cashews', 'celery', 'onion', 'peas', 'soy sauce']);
select cooking_camel_schema.insert('Cheese-Ham Ball',
                                   '["Mix all ingredients.", "Form into a ball and roll in chopped pecans.", "Serve with assorted crackers."]',
                                   '["1/2 lb. Cheddar cheese, shredded", "1 (8 oz.) pkg. cream cheese", "1 small flat can deviled ham", "1 Tbsp. pimiento, chopped", "approximately 1 Tbsp. dried parsley, soaked in water, then patted dry on paper towel", "dash of Worcestershire sauce", "1/2 tsp. fresh minced onion"]',
                                   ARRAY ['Cheddar cheese', 'cream cheese', 'ham', 'pimiento', 'parsley', 'Worcestershire sauce', 'onion']);
select cooking_camel_schema.insert('Pasta Chicken Salad(268 Calories Per Serving)  ',
                                   '["Cook large shells according to package directions.", "Drain and cool (rinse with cold water to cool quickly, then drain well). Combine cooled large shells with remaining ingredients and toss lightly.", "Chill.", "Makes 8 servings."]',
                                   '["3 1/2 c. (8 oz.) large shells (uncooked)", "2 c. cubed, cooked chicken (light meat)", "2 c. fresh, raw broccoli flowerets", "2 c. fresh, raw cauliflower", "1 c. sliced carrots", "1 c. sliced green onions", "1/2 lb. fresh mushrooms, sliced", "1 c. (8 oz. bottle) reduced calorie creamy Italian salad dressing", "3/4 c. skim milk", "salt and pepper to taste"]',
                                   ARRAY ['shells', 'chicken', 'broccoli flowerets', 'cauliflower', 'carrots', 'green onions', 'fresh mushrooms', 'Italian salad dressing', 'milk', 'salt']);
select cooking_camel_schema.insert('Zucchini-Artichoke Continental',
                                   '["In 2-quart microwave-safe casserole, microcook artichokes and water, covered, on 100% power (High) for 3 to 4 minutes or until thawed.", "Stir.", "Add next 3 ingredients.", "Cover.", "Cook on High for 9 to 11 minutes (low-wattage oven for 12 to 14 minutes) or just until tender; stir once.", "Drain well.", "Stir in garlic, 1/2 teaspoon salt and 1/4 teaspoon pepper.", "Dot with margarine or butter.", "Cover; cook on High for 1 minute.", "Stir in tomatoes; sprinkle with cheese.", "Let stand 2 minutes.", "Makes 6 servings."]',
                                   '["1 (9 oz.) pkg. frozen artichoke hearts", "2 Tbsp. water", "3 medium zucchini (1 lb.), sliced 1/4-inch thick (4 c.)", "2 c. fresh mushrooms, halved", "2 Tbsp. finely chopped green onion", "2 cloves garlic, minced", "1 Tbsp. margarine or butter", "2 medium tomatoes, cut into wedges and seeded", "1/4 c. grated Parmesan cheese"]',
                                   ARRAY ['frozen artichoke', 'water', 'zucchini', 'fresh mushrooms', 'green onion', 'garlic', 'margarine', 'tomatoes', 'Parmesan cheese']);
select cooking_camel_schema.insert('Supreme Beef Casserole',
                                   '["Melt shortening in a skillet.", "Add beef, breaking into pieces with a fork.", "Cook until brown.", "Drain off fat.", "Stir into meat the tomatoes and tomato sauce, adding salt, sugar and garlic. Simmer for 5 to 10 minutes.", "Meanwhile, cook the noodles.", "Drain well and with a fork blend in sour cream, cream cheese and onions."]',
                                   '["1 lb. ground chuck", "1 tsp. shortening", "1 (16 oz.) can tomatoes", "1 (8 oz.) can tomato sauce", "2 tsp. salt", "2 tsp. sugar", "2 garlic cloves, crushed", "1 (5 oz.) pkg. egg noodles", "1 c. sour cream", "1 (3 oz.) pkg. cream cheese", "6 green onions or scallions, chopped (with tops)", "1 c. grated cheese"]',
                                   ARRAY ['ground chuck', 'shortening', 'tomatoes', 'tomato sauce', 'salt', 'sugar', 'garlic', 'egg noodles', 'sour cream', 'cream cheese', 'green onions', 'grated cheese']);
select cooking_camel_schema.insert('Chicken Salad', '["Combine all ingredients; chill."]',
                                   '["1 (12.5 oz.) can chunk white chicken", "2 c. chopped celery", "1 small pkg. slivered almonds", "1 c. water chestnuts", "1 c. white grapes", "1/2 tsp. salt", "1/8 tsp. pepper", "1 tsp. lemon juice", "curry powder to caste", "nonfat mayonnaise"]',
                                   ARRAY ['chunk white chicken', 'celery', 'almonds', 'water chestnuts', 'white grapes', 'salt', 'pepper', 'lemon juice', 'curry powder', 'nonfat mayonnaise']);
select cooking_camel_schema.insert('Chess Pie',
                                   '["Mix ingredients in order given.", "Bake at 300\u00b0 to 325\u00b0 for 30 minutes or until firm."]',
                                   '["1 stick margarine", "1 1/2 c. sugar", "1 Tbsp. meal", "1 Tbsp. vinegar", "4 eggs (add one at a time)", "dash of salt", "1 tsp. vanilla"]',
                                   ARRAY ['margarine', 'sugar', 'meal', 'vinegar', 'eggs', 'salt', 'vanilla']);
select cooking_camel_schema.insert('Cold Spaghetti Salad',
                                   '["Cook noodles 1/2 done (do not rinse).", "Add all other ingredients; mix well.", "Marinate at least 3 hours.", "The longer it sits, the better it gets!!"]',
                                   '["1 lb. vermicelli", "1 lb. fine chopped bell pepper", "2 small zucchini, finely chopped", "1 large purple onion, sliced thin", "1 large bottle Bernstien Italian dressing", "1/2 to 3/4 jar Schilling Salad Supreme seasoning"]',
                                   ARRAY ['vermicelli', 'bell pepper', 'zucchini', 'purple onion', 'Salad Supreme seasoning']);
select cooking_camel_schema.insert('Cucumber Salad With Dill',
                                   '["Combine all ingredients, except dill, making sure juices are mixed well.", "Garnish with dill.", "Chill."]',
                                   '["2 cucumbers, sliced very thin", "1/3 c. white vinegar", "1 tsp. salt", "3 Tbsp. sugar", "1 large onion, sliced thin", "fresh dill"]',
                                   ARRAY ['cucumbers', 'white vinegar', 'salt', 'sugar', 'onion', 'dill']);
select cooking_camel_schema.insert('Chicken Spaghetti',
                                   '["Cook spaghetti and drain.", "Mix all other ingredients together.", "Add to spaghetti, place in a 13x9 casserole dish.", "Cook for 30 minutes at 350 degrees."]',
                                   '["1 (13 oz.) can cooked chicken", "1 (10 oz.) can cream of mushroom soup", "1 (10 oz.) can cream of chicken soup", "1 (10 oz.) can Rotel tomatoes", "1 to 2 c. cheese of your choice", "1 (16 oz.) pkg. spaghetti", "1 Tbsp. steak seasoning"]',
                                   ARRAY ['chicken', 'cream of mushroom soup', 'cream of chicken soup', 'tomatoes', 'your choice', 'spaghetti', 'steak seasoning']);
select cooking_camel_schema.insert('Pistachio Salad',
                                   '["Mix together all ingredients and refrigerate.", "Serve on lettuce leaf.", "Use 9 x 13-inch pan."]',
                                   '["pistachio pie filling (instant)", "1 can crushed pineapple", "1 c. miniature marshmallows", "1/2 container Cool Whip (small)"]',
                                   ARRAY ['pistachio pie filling', 'pineapple', 'marshmallows']);
select cooking_camel_schema.insert('Good Sweet Muffins',
                                   '["Heat oven to 400\u00b0.", "Beat egg with fork.", "Add remaining ingredients except blueberries and stir until flour is moistened. Batter should be lumpy.", "Add blueberries, if desired.", "Fill muffin cups 2/3 full.", "Bake 20 to 25 minutes.", "Serve warm."]',
                                   '["1 egg", "1/2 c. milk", "1/4 c. vegetable oil", "1 1/2 c. flour", "1/2 c. sugar", "2 tsp. baking powder", "1/2 tsp. salt", "1 c. blueberries (optional)"]',
                                   ARRAY ['egg', 'milk', 'vegetable oil', 'flour', 'sugar', 'baking powder', 'salt', 'blueberries']);
select cooking_camel_schema.insert('Vanilla Creme Dessert',
                                   '["Mix flour and melted margarine.", "Pat mixture in 9 x 13-inch baking pan.", "Bake at 375\u00b0 for 10 minutes.", "Let cool."]',
                                   '["1 c. flour", "1 stick margarine, melted", "1/2 c. crushed pecans", "1 large pkg. cream cheese", "1 large pkg. Cool Whip", "1 c. powdered sugar", "2 large pkg. instant vanilla pudding", "3 c. milk"]',
                                   ARRAY ['flour', 'margarine', 'pecans', 'cream cheese', 'powdered sugar', 'instant vanilla pudding', 'milk']);
select cooking_camel_schema.insert('St. JosephS Zeppole',
                                   '["Combine water, butter, sugar and salt in saucepan and bring to a boil.", "Add flour all at once, then beat with a wooden spoon for 1 minute or until mixture leaves sides of pan and forms a ball. Cool mixture.", "Add eggs one at a time, beating after each egg, until mixture has satin-like sheen.", "Use pastry bag with large star tip and fill with mixture.", "Make doughnut shape with pastry bag on greased cookie sheet.", "Bake in 400\u00b0 oven for 20 minutes or until puffed and well browned.", "Cool.", "Slice each zeppole in half and fill with the following filling."]',
                                   '["1 c. water", "1/2 c. butter", "1 tsp. sugar", "1 c. all-purpose flour", "4 large eggs"]',
                                   ARRAY ['water', 'butter', 'sugar', 'flour', 'eggs']);
select cooking_camel_schema.insert('Corn "Oysters"',
                                   '["Mix and let stand several hours or overnight.", "Drop by teaspoon in hot vegetable oil and fry until brown on both sides."]',
                                   '["1 can cream-style corn", "2 eggs", "1/2 tsp. grated onion", "8 to 10 finely rolled crackers", "salt"]',
                                   ARRAY ['cream-style corn', 'eggs', 'onion', 'crackers', 'salt']);
select cooking_camel_schema.insert('Bright Party Beans',
                                   '["Fry ground beef and dry onions.", "Add salt and pepper and chili powder.", "When browned, combine in large pan or roasting pan.", "Add all ingredients including juices.", "This will look like its watery.", "Bake at 270\u00b0 to 300\u00b0 for 4 hours.", "Do not stir during that time."]',
                                   '["2 lb. ground beef", "1 pkg. dry onion mix", "1 (No. 3) can B & M beans", "2 (15 oz.) cans kidney beans", "2 (15 oz.) cans small yellow lima beans", "2 cans green baby lima beans", "1/2 c. dark brown sugar", "1/2 c. dark or light Karo syrup", "1 tsp. chili powder", "1 c. ketchup", "1 Tbsp. dry mustard", "salt and pepper to taste"]',
                                   ARRAY ['ground beef', 'onion', 'beans', 'kidney beans', 'yellow lima beans', 'green baby', 'brown sugar', 'syrup', 'chili powder', 'ketchup', 'mustard', 'salt']);
select cooking_camel_schema.insert('Apricot Dessert',
                                   '["Mix cornstarch and sugar.", "Add nectar and cook, bringing to a boil.", "Stir constantly and cook until thickened.", "Cool slightly."]',
                                   '["1 angel food cake, broken into pieces", "46 oz. apricot nectar", "1 1/4 c. sugar", "7 Tbsp. cornstarch", "1 c. chopped walnuts"]',
                                   ARRAY ['cake', 'apricot nectar', 'sugar', 'cornstarch', 'walnuts']);
select cooking_camel_schema.insert('Honey Almond Squares',
                                   '["Bake cake as directed on package in 13 x 9-inch pan. Cool. Whip cream cheese until smooth. Add honey. Spread mixture over cake. Sprinkle with almonds. Store in refrigerator."]',
                                   '["1 Duncan Hines white pudding cake mix", "1 (8 oz.) pkg. cream cheese (at room temperature)", "1/4 c. alfalfa honey", "3 to 4 oz. sliced almonds"]',
                                   ARRAY ['cake mix', 'cream cheese', 'alfalfa honey', 'almonds']);
select cooking_camel_schema.insert('Artichoke Dip',
                                   '["Mix all ingredients. Pour into a 9 x 13-inch pan. Bake in preheated 350\u00b0 oven, uncovered, for 30 minutes. Serve hot with crackers."]',
                                   '["1 c. mayonnaise", "1 c. grated Parmesan or Romano cheese", "1 jar artichokes, drained and cut into small pieces"]',
                                   ARRAY ['mayonnaise', 'Romano cheese', 'artichokes']);
select cooking_camel_schema.insert('French Onion Soup',
                                   '["Heat butter in heavy kettle.", "Add sliced onions; brown well, stirring constantly.", "Add beef and chicken stock, the Worcestershire sauce, bay leaf, garlic salt and pepper.", "Allow to simmer for 40 minutes.", "Remove the bay leaf; add salt.", "Prepare with a slice of toasted French bread (1/2-inch thick).", "Add a thick slice of Swiss cheese (1/4-inch thick), overlapping the bowl.", "Put under the broiler until cheese is melted and bubbly."]',
                                   '["1/4 lb. butter", "2 1/2 lb. onions, sliced", "1 qt. beef stock (3 cans Campbells beef stock)", "1 qt. chicken stock (3 cans Campbells chicken stock)", "2 Tbsp. Worcestershire sauce", "1 bay leaf", "1 1/2 tsp. garlic salt", "1 tsp. black pepper (you may wish to use less)", "salt to taste (you may not want any)"]',
                                   ARRAY ['butter', 'onions', 'beef stock', 'chicken stock', 'Worcestershire sauce', 'bay leaf', 'garlic salt', 'black pepper', 'salt']);
select cooking_camel_schema.insert('Apple Pie',
                                   '["Put in unbaked pie shell.", "Top apples with 2 tablespoons margarine with crust.", "Brush milk on top of crust and sprinkle with sugar.", "Bake on bottom shelf at 400\u00b0 for 45 minutes."]',
                                   '["6 to 7 apples, sliced", "1 c. sugar", "2 Tbsp. flour", "1 tsp. cinnamon", "dash of salt and nutmeg"]',
                                   ARRAY ['apples', 'sugar', 'flour', 'cinnamon', 'salt']);
select cooking_camel_schema.insert('Sloppy Joes',
                                   '["Brown and drain hamburger.", "Add the remaining ingredients and simmer for 20 minutes."]',
                                   '["1 lb. hamburger", "1 c. ketchup", "3 Tbsp. Worcestershire sauce", "1 Tbsp. mustard", "2 Tbsp. sugar", "salt and pepper to taste"]',
                                   ARRAY ['hamburger', 'ketchup', 'Worcestershire sauce', 'mustard', 'sugar', 'salt']);
select cooking_camel_schema.insert('7-Up Cake',
                                   '["Mix sugar and butter thoroughly, then add egg, flour, egg, flour, etc. until all eggs and flour are mixed thoroughly, either with hand mixer or electric beater/mixer.", "Then add lemon flavor and your 7-Up (the 7-Up will make the cake rise); add yellow food coloring which is optional.", "Bake at 325\u00b0 to 350\u00b0 for 45 minutes to 1 hour, depending on oven.", "Insert toothpick after 45 minutes. Cook in Bundt pan. Let cool 25 minutes.", "Cake is done."]',
                                   '["3 c. flour", "3 c. sugar", "5 eggs", "3 sticks real butter (preferably Land O Lakes)", "3 Tbsp. lemon flavor", "3/4 c. 7-Up", "yellow food coloring (optional)"]',
                                   ARRAY ['flour', 'sugar', 'eggs', 'butter', 'lemon flavor', 'yellow food coloring']);
select cooking_camel_schema.insert('Corned Beef Dip', '["Mix ingredients together until they are completely blended."]',
                                   '["1 can corned beef", "1 (8 oz.) pkg. cream cheese", "2/3 c. mayonnaise", "1 c. chopped candied dill pickles", "2 Tbsp. chopped onion", "1/2 tsp. horseradish", "1 Tbsp. Worcestershire sauce", "2 tsp. Nance mustard", "3 Tbsp. pickle juice"]',
                                   ARRAY ['corned beef', 'cream cheese', 'mayonnaise', 'pickles', 'onion', 'horseradish', 'Worcestershire sauce', 'pickle juice']);
select cooking_camel_schema.insert('Chocolate Pie',
                                   '["Mix dry ingredients; add milk.", "Beat in egg yolks.", "Pour on 1 cup boiling water.", "Mix and cook until thick.", "Cool.", "Pour in baked pie shell.", "Cover with meringue and brown in oven."]',
                                   '["2 c. sugar", "1/2 c. milk", "3 Tbsp. cocoa", "3 heaping Tbsp. flour", "3 egg yolks", "1 clump (2 Tbsp.) butter", "1 tsp. vanilla", "1 c. boiling water"]',
                                   ARRAY ['sugar', 'milk', 'cocoa', 'flour', 'egg yolks', 'clump', 'vanilla', 'boiling water']);
select cooking_camel_schema.insert('Tater Tot Casserole',
                                   '["Spread Tater Tots in large cake pan, 9 x 13-inch. Brown meat and onions; drain well.", "Pour meat mixture over Tater Tots. Mix all 3 soups in a bowl.", "Pour over meat and Tater Tots. Sprinkle grated cheese to cover soup.", "Bake at 325\u00b0 for 1 hour.", "As you brown meat and onions, salt and pepper well."]',
                                   '["1 (32 oz.) bag Tater Tots", "2 lb. ground beef", "1 chopped onion", "1 chopped bell pepper", "1 can cream of mushroom soup", "1 can cream of celery soup", "1 can cream of chicken soup", "grated cheese"]',
                                   ARRAY ['Tater', 'ground beef', 'onion', 'bell pepper', 'cream of mushroom soup', 'cream of celery soup', 'cream of chicken soup', 'grated cheese']);
select cooking_camel_schema.insert('Blackberry Pie',
                                   '["Combine sugar, cornstarch and water in a heavy saucepan; cook over medium heat, stirring constantly, until thickened.", "Remove from heat; add gelatin, stirring until dissolved.", "Gently stir in blackberries.", "Pour into pastry shell.", "Chill until firm.", "Serve with Cool Whip or ice cream.", "Easy and so tasty."]',
                                   '["3/4 c. sugar", "2 1/2 Tbsp. cornstarch", "1 c. water", "3 1/2 Tbsp. blackberry flavored gelatin", "4 c. fresh blackberries", "1 baked 9-inch pastry shell"]',
                                   ARRAY ['sugar', 'cornstarch', 'water', 'flavored gelatin', 'fresh blackberries', 'pastry shell']);
select cooking_camel_schema.insert('Caramel Pie',
                                   '["Mix Cool Whip, softened cream cheese and Eagle Brand milk. Beat for 1 minute.", "Pour in pie crusts.", "Melt margarine and mix with coconut and almonds.", "Place on cookie sheet and cook for 10 minutes at 350\u00b0.", "Watch closely and stir often.", "(I like mine toasty.)", "Pour coconut, almond mixture over top of pies.", "Pour caramel topping over the 3 pies.", "Freeze."]',
                                   '["16 oz. Cool Whip", "2 c. coconut", "3/4 margarine, melted", "1 c. slivered almonds, chopped fine", "1 can Eagle Brand milk", "3 graham cracker crusts", "8 oz. cream cheese", "1 jar caramel topping"]',
                                   ARRAY ['coconut', 'margarine', 'slivered almonds', 'milk', 'graham cracker crusts', 'cream cheese', 'caramel topping']);
select cooking_camel_schema.insert('Dill Dip',
                                   '["Mix all ingredients together.", "Let sit in refrigerator several hours before serving.", "Serve with raw cauliflower, broccoli, carrots, celery, mushrooms and cherry tomatoes."]',
                                   '["3/4 c. Miracle Whip salad dressing", "1 c. sour cream", "1/2 Tbsp. minced onion", "1/2 Tbsp. parsley flakes", "1/2 Tbsp. dill weed"]',
                                   ARRAY ['Miracle', 'sour cream', 'onion', 'parsley flakes', 'dill weed']);
select cooking_camel_schema.insert('Broccoli Cornbread',
                                   '["Fry onion in oil.", "Set aside.", "Cook broccoli as directed. Drain and set aside.", "Melt oleo.", "Grease 8 x 8-inch pan.", "Mix cornbread mix and eggs.", "Add cottage cheese, broccoli, onions and melted oleo margarine.", "Stir well.", "Pour into pan and bake at 450\u00b0 for 20 to 25 minutes."]',
                                   '["1/2 chopped medium onion", "1 Tbsp. oil", "5 oz. frozen broccoli", "1/2 stick margarine", "1 pkg. Jiffy cornbread mix", "2 eggs", "6 oz. cottage cheese"]',
                                   ARRAY ['onion', 'oil', 'frozen broccoli', 'margarine', 'mix', 'eggs', 'cottage cheese']);
select cooking_camel_schema.insert('Vegetable Soup',
                                   '["Slice the vegetables.", "Cook in small amount of water until tender.", "Add the cooked macaroni, green beans and peas.", "Add bay leaf and Italian seasoning.", "Cook beef or turkey until it changes color.", "Add to vegetables.", "Pour in tomato juice.", "Bring to boil. Reduce to simmer.", "If soup is too thick, add more tomato juice."]',
                                   '["1 medium onion, diced", "1 potato, diced", "1 1/2 green sweet peppers, diced", "1/2 c. diced celery", "1 c. diced carrots", "1 c. small macaroni, cooked", "1 1/2 lb. ground turkey or beef", "14 oz. can French green beans", "1 large bay leaf", "1 tsp. Italian seasoning", "1 c. sweet peas", "1 can tomato juice"]',
                                   ARRAY ['onion', 'potato', 'green sweet peppers', 'celery', 'carrots', 'macaroni', 'ground turkey', 'beans', 'bay leaf', 'Italian seasoning', 'sweet peas', 'tomato juice']);
select cooking_camel_schema.insert('Chocolate Peanut Butter Cake',
                                   '["In saucepan, melt oleo; add cocoa.", "Combine remaining ingredients and add oleo-cocoa mixture.", "Bake in 9 x 13-inch pan for 30 minutes at 350\u00b0.", "While still hot, punch holes in cake. Spread on cake, 1/2 cup peanut butter mixed with 1 1/2 tsp. oil."]',
                                   '["1/4 c. cocoa", "2 sticks oleo", "2 c. flour", "2 c. sugar", "1 tsp. baking soda", "dash of salt", "2 eggs", "1 tsp. vanilla", "1 c. water", "1/2 c. buttermilk"]',
                                   ARRAY ['cocoa', 'oleo', 'flour', 'sugar', 'baking soda', 'salt', 'eggs', 'vanilla', 'water', 'buttermilk']);
select cooking_camel_schema.insert('Magic Cookie Bars',
                                   '["Preheat oven to 350\u00b0 (325\u00b0 for glass dish).", "In 13 x 9-inch pan, melt butter in oven.", "Sprinkle with crumbs.", "Top with Eagle Brand milk evenly.", "Top with remaining ingredients.", "Press down. Bake 25 to 30 minutes until lightly brown.", "Cool or chill.", "Cut into bars; store, loosely covered, at room temperature."]',
                                   '["1/2 c. butter", "1 1/2 c. graham cracker crumbs", "1 (14 oz.) can Eagle Brand milk", "6 oz. semi-sweet chocolate chips", "1 (3 1/2 oz.) can flaked coconut (1 1/2 c.)", "1 c. chopped nuts"]',
                                   ARRAY ['butter', 'graham cracker crumbs', 'milk', 'semi-sweet chocolate chips', 'flaked coconut', 'nuts']);
select cooking_camel_schema.insert('Pecan Pralines',
                                   '["Combine sugars and evaporated milk in heavy saucepan. Cook over medium heat. Stir in butter, pecans and coconut. Cook until candy reaches soft ball stage. (Mixture will form a soft ball when dropped in a cup of cold water.)", "Cool 2 minutes. Beat until thick, but glossy.", "Drop by tablespoon onto wax paper. Cool thoroughly."]',
                                   '["1 c. sugar", "1 c. packed brown sugar", "1/3 c. evaporated milk", "1/2 stick butter or margarine, softened", "1 1/2 c. pecans", "1 1/2 c. coconut"]',
                                   ARRAY ['sugar', 'brown sugar', 'milk', 'butter', 'pecans', 'coconut']);
select cooking_camel_schema.insert('Chocolate "Stuff"',
                                   '["Make pudding as directed on package, then add vanilla wafers. Smooth on Cool Whip and sprinkle with pecans."]',
                                   '["1 large box instant chocolate pudding mix", "1 small bag vanilla wafers", "1 small tub Cool Whip", "1 small pkg. chopped pecans (about 1/2 c.)"]',
                                   ARRAY ['chocolate pudding', 'vanilla wafers', 'pecans']);
select cooking_camel_schema.insert('Easy Chocolate Frosting',
                                   '["Bring sugar, butter and milk to a boil and boil 1 minute. Remove from stove and add chocolate chips and vanilla and beat. (Might need about 1/2 cup powdered sugar.)"]',
                                   '["1 1/3 c. white sugar", "6 Tbsp. butter", "6 Tbsp. milk", "1/2 c. chocolate chips", "1/2 tsp. vanilla"]',
                                   ARRAY ['white sugar', 'butter', 'milk', 'chocolate chips', 'vanilla']);
select cooking_camel_schema.insert('No Bake Pumpkin Pie',
                                   '["Combine gelatine, spices, condensed milk and eggs on low heat until gelatine dissolves (10 minutes). Remove from heat. Stir in pumpkin.", "Pour in baked pie shells, then chill 3 hours. Garnish with Cool Whip and chopped pecans."]',
                                   '["1 envelope Knox unflavored gelatine", "1 (14 oz.) Eagle Brand milk", "2 eggs, beaten", "1 (16 oz.) can pumpkin (not pumpkin mix)", "1 tsp. cinnamon", "1/2 tsp. ginger", "1/2 tsp. salt", "2 pie shells, baked"]',
                                   ARRAY ['unflavored gelatine', 'milk', 'eggs', 'pumpkin', 'cinnamon', 'ginger', 'salt', 'pie shells']);
select cooking_camel_schema.insert('Baked French Toast',
                                   '["Mix all well in medium bowl and cut one 16 ounce loaf of Italian bread into 1-inch slices. Dip bread into mixture and put into large glass baking dish. Pour any remaining mixture over bread. Refrigerate overnight."]',
                                   '["5 large eggs, slightly beaten", "1/4 c. sugar", "1/4 tsp. ground nutmeg", "2/3 c. orange juice", "1/3 c. half and half cream", "1/2 tsp. vanilla"]',
                                   ARRAY ['eggs', 'sugar', 'ground nutmeg', 'orange juice', 'cream', 'vanilla']);
select cooking_camel_schema.insert('Puppy Chow',
                                   '["Pour cereal into a very large bowl.", "In a 1-quart bowl, combine chips, peanut butter and margarine; microwave on High for 1 to 1 1/2 minutes until smooth.", "(Stir after 1 minute.)", "Pour chocolate mixture over cereal, stirring all pieces until all are coated.", "Then little by little, add the powdered sugar.", "Stir well each time the powdered sugar is added.", "May not need entire box of powdered sugar."]',
                                   '["9 c. Chex cereal", "1 c. chocolate chips", "1 1/2 c. powdered sugar", "1/2 c. peanut butter", "1/4 c. margarine", "1 tsp. vanilla"]',
                                   ARRAY ['cereal', 'chocolate chips', 'powdered sugar', 'peanut butter', 'margarine', 'vanilla']);
select cooking_camel_schema.insert('Tamale Casserole',
                                   '["Preheat oven to 350\u00b0.", "Peel wrappers off tamales and chop in large bowl.", "Drain hominy, olives and peppers.", "Add them to tamales.", "Mix well.", "Place in 9 x 13 x 3-inch baking dish.", "Spread out evenly.", "Sprinkle cheese over top and olives if desired.", "Bake 20 to 30 minutes.", "Serves 8.", "Serve with Spanish rice and corn chips."]',
                                   '["1 (16 oz.) can yellow hominy", "1 (4 oz.) can chopped olives", "1 (4 oz.) can mild green chilies", "2 (16 oz.) cans tamales", "2 c. shredded mild Cheddar cheese", "1/4 c. dried chopped onions"]',
                                   ARRAY ['yellow hominy', 'olives', 'green chilies', 'tamales', 'Cheddar cheese', 'onions']);
select cooking_camel_schema.insert('Taco Dip',
                                   '["Layer the above ingredients in a 9 x 13 inch dish.", "Press down with spatula.", "Serve with Doritos."]',
                                   '["1 small can refried beans", "1 small carton guacamole dip", "1 c. sour cream", "3 Tbsp. mayonnaise", "1 pkg. taco seasoning", "1 c. Mozzarella cheese", "1 c. cheddar cheese", "Chopped green onions, tomato and black olives (optional)"]',
                                   ARRAY ['beans', 'guacamole dip', 'sour cream', 'mayonnaise', 'taco seasoning', 'Mozzarella cheese', 'cheddar cheese', 'green onions']);
select cooking_camel_schema.insert('BonnieS Bread',
                                   '["Can use dehydrated potato flakes.", "Add flour as desired. Dough should be soft and elastic.", "Bake as rolls or bread at 350\u00b0. Bread is done when it sounds hollow when tapped."]',
                                   '["4 c. water or potato water", "1 cake yeast or 3 pkg. dry yeast", "2 Tbsp. salt", "2 eggs, well beaten", "1 c. sugar or more"]',
                                   ARRAY ['water', 'cake yeast', 'salt', 'eggs', 'sugar']);
select cooking_camel_schema.insert('Chicken Pot Pie',
                                   '["Combine the first five ingredients and place in a 9 x 12-inch casserole dish.", "Mix next four ingredients and pour over top of chicken mixture.", "Do not stir.", "Bake at 425\u00b0 for 45 minutes to one hour until crust rises and browns."]',
                                   '["2 c. chicken, cooked and cubed", "1 can cream of mushroom soup", "3 c. chicken broth", "1 can peas and carrots, drained", "1 chopped onion", "3/4 c. oleo, melted", "1 1/2 c. milk", "1 1/2 tsp. baking powder", "1 1/2 c. self-rising flour"]',
                                   ARRAY ['chicken', 'cream of mushroom soup', 'chicken broth', 'peas', 'onion', 'oleo', 'milk', 'baking powder', 'flour']);
select cooking_camel_schema.insert('Smoked Turkey Risotto',
                                   '["In medium-size saucepan, bring the stock to a boil over medium heat.", "Lower the heat, add the artichoke hearts, cover and simmer for about 10 minutes or until tender.", "With a slotted spoon, transfer the artichoke hearts to a bowl and cover to keep warm."]',
                                   '["3 c. chicken stock or vegetable stock", "1 pkg. (10 oz.) frozen artichoke hearts", "2 t. olive or canola oil", "3 green onions, including tops, sliced (1/3 c.)", "1 clove garlic, minced", "1 c. arborio, basmati, or long-grain, white rice", "1/2 t. dried oregano, crumbled", "1/2 t. salt", "1/4 t. black pepper", "4 oz. spinach, rinsed, trimmed and thinly sliced (2 c.)", "3 T. grated parmesan cheese"]',
                                   ARRAY ['chicken', 'olive', 'green onions', 'clove garlic', 'arborio', 'oregano', 'salt', 'black pepper', 'spinach', 'parmesan cheese']);
select cooking_camel_schema.insert('Eggplant Spaghetti Sauce',
                                   '["Heat oil in large pot.", "Add all the vegetables and the garlic. Saute over medium heat for 15 minutes stirring frequently.", "Add tomatoes and tomato sauce and all the seasonings.", "Bring to a boil and then reduce heat.", "Cover and simmer for 3 to 4 hours.", "During the last hour of cooking, add the wine."]',
                                   '["1/2 c. oil (I use olive oil, extra light)", "1 large eggplant, unpeeled and chopped", "2 medium onions chopped", "1/2 head cauliflower, chopped", "1 green pepper, chopped", "1/2 c. fresh parsley (flat Italian), chopped", "1/4 lb. mushrooms, sliced", "8 cloves garlic, minced or mashed", "2 very large cans Italian tomatoes", "1 bay leaf", "1 tsp. dried basil", "1 tsp. oregano", "1 tsp. thyme", "1/2 tsp. marjoram", "1/2 tsp. rosemary", "1/2 tsp. salt, optional", "1 c. dry red or white wine"]',
                                   ARRAY ['oil', 'eggplant', 'onions', 'cauliflower', 'green pepper', 'fresh parsley', 'mushrooms', 'garlic', 'Italian tomatoes', 'bay leaf', 'basil', 'oregano', 'thyme', 'marjoram', 'rosemary', 'salt', 'red']);
select cooking_camel_schema.insert('Watergate Cake',
                                   '["Combine box cake mix, oil, instant pudding, ginger ale, eggs, and pecans.", "Pour into a 13 x 9-inch pan that has been greased and floured.", "Bake at 350\u00b0 for 30 minutes. Cool and add topping when ready to serve. For topping the cake, mix cool whip, milk and pistachio instant pudding mix. Pour over cake and let set."]',
                                   '["1 box white cake mix", "1 c. + 1 Tbsp. vegetable oil", "1 pkg. pistachio instant pudding mix", "1 c. ginger ale", "3 eggs", "1/2 c. chopped pecans", "1 (8-oz.) pkg. cool whip", "3/4 c. milk", "1 pkg. of pistachio instant pudding mix"]',
                                   ARRAY ['white cake mix', '+', 'pistachio instant pudding', 'ginger ale', 'eggs', 'pecans', 'cool whip', 'milk', 'pistachio instant pudding']);
select cooking_camel_schema.insert('Plum Muffins',
                                   '["Mix all ingredients together.", "Drop into greased muffin tins. Bake at 325\u00b0 for 15 to 20 minutes or until done."]',
                                   '["2 c. self-rising flour", "1 c. crushed walnuts", "3 eggs", "2 small jars baby food plums", "2 c. sugar", "2 tsp. allspice", "1 c. oil"]',
                                   ARRAY ['flour', 'walnuts', 'eggs', 'sugar', 'allspice', 'oil']);
select cooking_camel_schema.insert('Cranberry Punch', '["Mix and put in punch bowl.", "Top with sherbert."]',
                                   '["1 qt. cranberry juice", "1 qt. ginger ale", "1 small cherry Jell-O", "1 c. boiling water", "6 oz. frozen lemonade", "3 c. cold water"]',
                                   ARRAY ['cranberry juice', 'ginger ale', 'O', 'boiling water', 'frozen lemonade', 'cold water']);
select cooking_camel_schema.insert('Sweet Potato Pie',
                                   '["With mixer, cream potatoes, butter and sugar until smooth and creamy.", "Watch out for strings in potatoes.", "Add eggs, one at a time.", "Mix after each egg.", "Add seasoning, then milk.", "Pour into unbaked pie shell.", "Bake at 350\u00b0 for 45 minutes."]',
                                   '["4 sweet potatoes, boiled and drained", "2 sticks butter", "2 c. sugar", "4 to 6 eggs", "nutmeg (season to taste)", "2 c. Milnot"]',
                                   ARRAY ['sweet potatoes', 'butter', 'sugar', 'eggs', 'nutmeg']);
select cooking_camel_schema.insert('Butternut Pound Cake',
                                   '["Cream sugar and Crisco well.", "Add eggs, one at a time.", "Beat well.", "Add flour and milk alternately on medium.", "Last, add flavors.", "Beat 2 minutes.", "Heat oven to 325\u00b0.", "Pour batter into greased and floured cake pan.", "Bake for 1 hour."]',
                                   '["2 c. sugar", "1 c. Crisco oil", "4 eggs", "2 1/2 c. self-rising flour", "1/2 c. sweet milk", "1 tsp. vanilla flavor", "1 Tbsp. butternut flavor"]',
                                   ARRAY ['sugar', 'Crisco oil', 'eggs', 'flour', 'sweet milk', 'vanilla flavor', 'butternut flavor']);
select cooking_camel_schema.insert('Morning Glory Muffins',
                                   '["Combine first 5 ingredients in a large mixing bowl; stir in carrots and next 4 ingredients.", "Make a well in center of mixture. Combine vegetable oil and remaining ingredients.", "Add to flour mixture, stirring until moistened.", "Place paper baking cups in muffin pans.", "Spoon batter into paper cups, filling 2/3 full. Bake at 350\u00b0 for 25 minutes or until golden brown.", "Remove from pans immediately.", "Makes 22 muffins."]',
                                   '["2 c. all-purpose flour", "1 1/2 c. sugar", "2 tsp. baking soda", "1 tsp. ground cinnamon", "1/2 tsp. salt", "2 c. grated carrots", "1/2 c. raisins", "1/2 c. coconut", "1/2 c. chopped pecans", "1 (8 oz.) can crushed pineapple, drained", "1 c. vegetable oil", "3 large eggs, lightly beaten", "2 tsp. vanilla"]',
                                   ARRAY ['flour', 'sugar', 'baking soda', 'ground cinnamon', 'salt', 'carrots', 'raisins', 'coconut', 'pecans', 'pineapple', 'vegetable oil', 'eggs', 'vanilla']);
select cooking_camel_schema.insert('Chicken Breasts With Wild Rice',
                                   '["Combine first 5 ingredients together.", "Pour into greased 9 x 13-inch microwave dish.", "Lay chicken breasts on top of rice mixture, with heavy side of breasts at corners of the dish.", "Brush with melted butter or margarine and sprinkle evenly with cornflake crumbs."]',
                                   '["1 3/4 c. quick cooking long grain and wild rice or plain rice", "1 (10 3/4 oz.) can condensed cream of mushroom or chicken soup (undiluted)", "1 (10 3/4 oz.) can French onion soup (undiluted)", "2 1/2 oz. jar sliced mushrooms (undrained)", "1/2 c. water", "4 chicken breasts", "2 Tbsp. melted butter or margarine", "1/4 c. cornflake crumbs or cracker crumbs"]',
                                   ARRAY ['wild rice', 'condensed cream', 'onion soup', 'mushrooms', 'water', 'chicken breasts', 'butter', 'cornflake crumbs']);
select cooking_camel_schema.insert('Creole Green Beans',
                                   '["Saute green pepper and onion in hot bacon drippings until tender. Add flour, salt, sugar and paprika.", "Stir until blended. Add tomatoes and simmer for about 15 minutes.", "Stir in green peas; heat through and serve."]',
                                   '["1 green pepper, chopped", "1 onion, chopped", "2 Tbsp. bacon drippings", "1 Tbsp. flour", "1 tsp. salt", "1 tsp. sugar", "dash of paprika", "1 (16 oz.) can tomatoes", "1 (16 oz.) can green peas"]',
                                   ARRAY ['green pepper', 'onion', 'bacon drippings', 'flour', 'salt', 'sugar', 'paprika', 'tomatoes', 'green peas']);
select cooking_camel_schema.insert('Banana Bread',
                                   '["Mix eggs, bananas, butter and sugar in blender or food processor.", "Mix remaining ingredients.", "Add the two mixtures together.", "Pour in greased pan and bake at 350\u00b0 for 45 minutes."]',
                                   '["2 eggs", "3 bananas, cut in small pieces", "1 stick butter, cut in small pieces", "1 c. sugar", "1 3/4 c. flour", "3/4 tsp. soda", "1 1/4 tsp. cream of tartar", "1 c. chopped nuts (optional)"]',
                                   ARRAY ['eggs', 'bananas', 'butter', 'sugar', 'flour', 'soda', 'cream of tartar', 'nuts']);
select cooking_camel_schema.insert('Corned Beef Hash Swirls',
                                   '["Make dough according to Bisquick directions on box.", "Roll out until about 1 inch thick.", "(Shape, as you roll out into an oblong shape.)", "Thinly spread with a knife, mustard on top of dough. Then, salt and pepper lightly or to taste.", "Spread corned beef hash on top of the mustard, salt and pepper.", "Then, lengthwise, roll up securely and pan freeze.", "When frozen, take out and with a sharp knife, cut roll into 3/4 to 1 inch slices.", "Bake in moderate oven at approximately 350\u00b0 for 15 or 20 minutes or freeze, individually and reheat frozen for a longer period of time.", "Whether you serve right away or serve after being frozen, pour on top either a cream cheese sauce or a sauce made of 1 can of cream of celery soup, adding a little water.", "A good lunch!!"]',
                                   '["Bisquick", "can corned beef hash", "mustard", "salt and pepper to taste"]',
                                   ARRAY ['Bisquick', 'beef hash', 'mustard', 'salt']);
select cooking_camel_schema.insert('Patio Potatoes',
                                   '["Mix all together and put in greased 9 x 13-inch casserole dish.", "Top with 2 cups corn flakes (crushed) and mixed with 1/2 cup melted margarine.", "Bake at 350\u00b0 for 45 minutes."]',
                                   '["1 (2 lb.) bag hash browns, thawed", "1/2 c. melted margarine", "1/2 tsp. salt", "1/2 tsp. pepper", "1/2 c. chopped onion", "1 can cream of mushroom soup", "1 pt. sour cream", "10 oz. or 2 c. grated sharp Cheddar cheese"]',
                                   ARRAY ['hash browns', 'margarine', 'salt', 'pepper', 'onion', 'cream of mushroom soup', 'sour cream', 'grated sharp']);
select cooking_camel_schema.insert('Sky High Biscuits',
                                   '["Combine dry ingredients.", "Cut in butter as you would for pie crust.", "Add milk and egg quickly and stir briefly.", "Knead for a few minutes.", "Roll to 1-inch thickness.", "Cut into biscuits.", "Bake at 450\u00b0 for 12 to 15 minutes on greased cookie sheets."]',
                                   '["3 c. flour", "4 1/2 tsp. baking powder", "2 Tbsp. sugar", "1/2 tsp. salt", "3/4 c. cream of tartar", "3/4 c. butter", "1 egg, beaten", "1 c. milk"]',
                                   ARRAY ['flour', 'baking powder', 'sugar', 'salt', 'cream of tartar', 'butter', 'egg', 'milk']);
select cooking_camel_schema.insert('Lasagne',
                                   '["In a large skillet brown the hamburger.", "Drain the fat.", "Stir in the jar of spaghetti sauce.", "Heat until warm.", "In a 3 to 4-quart saucepan fill to about an inch below the rim with water. Bring to a boil and add noodles.", "Cook until soft.", "In a large baking pan (8 x 10-inch or bigger) cover the bottom with 4 noodles.", "Smother with Mozzarella (and Ricotta if you have it) and start your next layer of noodles.", "Bake in oven at 350\u00b0 until cheese is melted."]',
                                   '["1 lb. lean hamburger", "1 jar Ragu spaghetti sauce (plain)", "1 small container Ricotta cheese", "1 pkg. lasagne noodles (approximately 8 noodles)", "1 large bag preshredded Mozzarella cheese"]',
                                   ARRAY ['lean hamburger', 'Ricotta cheese', 'lasagne noodles', 'Mozzarella cheese']);
select cooking_camel_schema.insert('German Potato Salad',
                                   '["Boil the potatoes until done.", "Peel and slice while still warm.", "Stir while pouring on the vinegar and hot grease.", "Garnish with the bacon and chopped parsley, if available.", "Sprinkle with sugar if too tart due to the vinegar."]',
                                   '["4 lb. new potatoes (red skin)", "2 good size onions, finely chopped", "3 stalks celery, finely chopped", "1/2 c. cider vinegar", "1/2 c. hot bacon drippings", "8 strips bacon, fried and crumbled", "salt and pepper to taste", "parsley"]',
                                   ARRAY ['new potatoes', 'onions', 'stalks celery', 'cider vinegar', 'hot bacon', 'bacon', 'salt', 'parsley']);
select cooking_camel_schema.insert('Coconut Pie',
                                   '["Mix flour, sugar and coconut in a bowl.", "Beat eggs and add milk, butter and flavoring. Then add dry ingredients.", "Pour into well greased pie plate and bake at 350\u00b0 for 45 minutes to 1 hour or until golden brown.", "This pie makes its own crust."]',
                                   '["4 eggs", "2 c. milk", "1 tsp. vanilla", "1/4 c. melted butter", "1 3/4 c. sugar", "1/2 c. self-rising flour", "1 1/2 c. coconut"]',
                                   ARRAY ['eggs', 'milk', 'vanilla', 'butter', 'sugar', 'flour', 'coconut']);
select cooking_camel_schema.insert('Bullets',
                                   '["Mix together ground beef with salt and pepper and enough flour to hold meat together.", "Roll into meat balls. Roll meat balls in more flour to coat. Drop meat balls into boiling water and cook. It will make its own gravy.", "Serve over rice or mashed potatoes. May add more seasoning to taste as these are very bland."]',
                                   '["ground beef", "flour", "salt and pepper to taste"]',
                                   ARRAY ['ground beef', 'flour', 'salt']);
select cooking_camel_schema.insert('MomS Pancakes',
                                   '["Sift flour with baking powder, salt and sugar into a medium bowl.", "With rotary beater, beat egg.", "Add milk and butter; beat until well mixed.", "Pour this into dry ingredients; beat only until combined.", "Batter will be lumpy."]',
                                   '["1 c. sifted all-purpose flour", "2 tsp. baking powder", "1/2 tsp. salt", "2 Tbsp. sugar", "1 egg", "1 c. milk", "3 Tbsp. butter or margarine, melted"]',
                                   ARRAY ['flour', 'baking powder', 'salt', 'sugar', 'egg', 'milk', 'butter']);
select cooking_camel_schema.insert('Pecan Kisses',
                                   '["Beat egg white until stiff.", "Add sugar and vanilla; mix well. Dip 2 or 3 pecans at a time.", "Place on ungreased baking sheet. Bake at 250\u00b0 for 30 minutes.", "Leave in oven for 30 more minutes with the oven turned off."]',
                                   '["1 egg white", "2/3 c. light brown sugar", "1 tsp. vanilla", "4 c. whole pecans"]',
                                   ARRAY ['egg', 'light brown sugar', 'vanilla', 'pecans']);
select cooking_camel_schema.insert('Pizza Casserole',
                                   '["Brown beef; stir to crumble.", "Drain.", "Put beef into 8-inch baking dish.", "Top with sauce, Mozzarella cheese and sliced mushrooms.", "Combine the biscuit mix, milk and eggs; beat until smooth, then evenly pour over casserole.", "Bake at 400\u00b0 for 30 to 35 minutes."]',
                                   '["1 lb. ground beef", "14 oz. Pizza Quick sauce", "2 c. shredded Mozzarella cheese", "1 jar sliced mushrooms", "3/4 c. biscuit mix", "1 1/2 c. milk", "2 eggs"]',
                                   ARRAY ['ground beef', 'sauce', 'Mozzarella cheese', 'mushrooms', 'biscuit mix', 'milk', 'eggs']);
select cooking_camel_schema.insert('Chocolate LoverS No-Bake Brownies',
                                   '["Melt chocolate chips over hot (not boiling) water; stir until smooth.", "Add sweetened condensed milk, chocolate wafer crumbs and one-half cup of nuts; stir until well blended.", "Press into foil-lined 8-inch square pan.", "Press remaining 1/2 cup of nuts into top of brownies.", "Let stand at room temperature until firm. Cut into 2-inch squares."]',
                                   '["1 (12 oz.) pkg. (2 c.) semi-sweet chocolate chips", "1 (14 oz.) can sweetened condensed milk", "1 (8 1/2 oz.) pkg. chocolate wafers, finely crushed", "1 c. chopped nuts, divided"]',
                                   ARRAY ['semi-sweet chocolate chips', 'condensed milk', 'chocolate wafers', 'nuts']);
select cooking_camel_schema.insert('Broccoli Casserole',
                                   '["Cook broccoli according to directions on package.", "Drain. Arrange in dish.", "Combine other ingredients and cover broccoli. Sprinkle with grated cheese or crushed Ritz crackers.", "Bake at 350\u00b0 for 40 minutes."]',
                                   '["1 pkg. frozen chopped broccoli", "1/2 c. mushroom soup", "1/2 c. mayonnaise", "1 beaten egg", "1 small onion, chopped", "salt and pepper"]',
                                   ARRAY ['broccoli', 'mushroom soup', 'mayonnaise', 'egg', 'onion', 'salt']);
select cooking_camel_schema.insert('Fruit Bars',
                                   '["Heat oven to 350\u00b0.", "Mix flour, sugar, baking powder, salt, almond extract and eggs.", "Stir in remaining ingredients.", "Spread dough in greased pan (13 x 9 x 2-inch).", "Bake until light brown, 30 to 35 minutes."]',
                                   '["1 1/4 c. all-purpose flour", "1 1/2 tsp. baking powder", "1/2 tsp. almond extract", "1 c. chopped nuts", "1/2 c. chopped maraschino cherries, drained", "1 c. sugar", "1 tsp. salt", "3 eggs", "1 c. cut up dates or whole raisins", "1 (6 oz.) pkg. semi-sweet chocolate chips"]',
                                   ARRAY ['flour', 'baking powder', 'almond extract', 'nuts', 'maraschino cherries', 'sugar', 'salt', 'eggs', 'dates', 'semi-sweet chocolate chips']);
select cooking_camel_schema.insert('Chinese Hamburger',
                                   '["Brown hamburger. Add onion and celery until transparent; drain. Add soups, water, rice, soy sauce and pepper. Transfer to a casserole dish. Bake at 350\u00b0 for 20 minutes. Top with chow mein noodles and cook for 10 minutes more."]',
                                   '["1 lb. hamburger", "2 Tbsp. oil", "1 onion, chopped", "1 celery rib, chopped", "1 c. cooked rice", "1 can cream of mushroom soup", "1 can cream of chicken soup", "1 1/2 c. warm water", "1/4 c. soy sauce", "1/4 tsp. pepper", "1 can chow mein noodles"]',
                                   ARRAY ['hamburger', 'oil', 'onion', 'celery', 'rice', 'cream of mushroom soup', 'cream of chicken soup', 'water', 'soy sauce', 'pepper', 'noodles']);
select cooking_camel_schema.insert('Almond Roco',
                                   '["Cook until hard ball stage in cold water.", "Add 1/2 cup chopped almonds and cook until it reaches cracked candy stage, 300\u00b0, on candy thermometer.", "Melt the 3 chocolate candy bars and pour on top and sprinkle chopped almonds."]',
                                   '["1 lb. butter (not margarine)", "2 c. granulated sugar", "1/2 c. water", "1/2 c. chopped almonds", "3 chocolate candy bars", "1/4 c. chopped almonds or as desired (for topping)"]',
                                   ARRAY ['butter', 'sugar', 'water', 'almonds', 'chocolate', 'almonds']);
select cooking_camel_schema.insert('Hungarian-Stuffed Peppers',
                                   '["Prepare peppers (remove white sections).", "Mix ground beef, rice, egg and seasoning.", "Fill peppers; place in deep cooking vessel.", "Cover with V-8.", "Cook for 1 hour at 350\u00b0."]',
                                   '["4 large peppers", "1 large can V-8", "1 onion, chopped", "1/2 tsp. garlic powder", "1 lb. ground beef", "1/2 c. rice", "1 egg", "salt to taste"]',
                                   ARRAY ['peppers', 'onion', 'garlic powder', 'ground beef', 'rice', 'egg', 'salt']);
select cooking_camel_schema.insert('Lemon Pudding Pound Cake',
                                   '["Beat eggs.", "Add cake mix, pudding, water and oil.", "Beat at medium speed for 10 minutes.", "Pour into an ungreased 10-inch tube pan with removable bottom.", "Bake at 350\u00b0 about 50 minutes.", "Cool slightly and remove from pan."]',
                                   '["5 eggs", "1 box yellow cake mix", "3/4 c. water", "1 small pkg. instant lemon pudding", "1/2 c. oil"]',
                                   ARRAY ['eggs', 'yellow cake mix', 'water', 'oil']);
select cooking_camel_schema.insert('Peanut Butter Cup Cookies',
                                   '["Cream butter, peanut butter, brown sugar and white sugar.", "Beat in egg and vanilla.", "Sift flour, baking soda and salt.", "Add flour mixture to creamed mixture.", "Shape into 1-inch balls.", "Spray miniature muffin pans with nonstick spray and place balls of dough in pans.", "Do not spread dough in cups.", "Bake at 350\u00b0 for 8 to 10 minutes or lightly browned.", "Remove from heat and immediately press peanut butter cup into each cookie until only top shows.", "Let cool in tins for 10 to 15 minutes.", "These freeze well.", "Makes about 4 dozen."]',
                                   '["1/2 c. butter or margarine", "1/2 c. peanut butter", "1/2 c. brown sugar", "1/2 c. white sugar", "1 egg", "1/2 tsp. vanilla", "1 1/4 c. sifted flour", "3/4 tsp. baking soda", "1/2 tsp. salt", "1 (10 oz.) bag miniature Reeses peanut butter cups"]',
                                   ARRAY ['butter', 'peanut butter', 'brown sugar', 'white sugar', 'egg', 'vanilla', 'flour', 'baking soda', 'salt', 'butter']);
select cooking_camel_schema.insert('Egg Cheese Souffle',
                                   '["In greased baking dish, place croutons and Velveeta.", "Mix eggs, milk, mustard, salt, onion powder and pepper.", "Pour on top of cheese.", "Place crumbled bacon on top.", "Bake at 325\u00b0 for 50 minutes."]',
                                   '["4 eggs", "2 c. milk", "1/2 tsp. mustard", "1/2 tsp. salt", "1/8 tsp. onion powder", "dash of pepper", "2 c. croutons (cheese)", "1 c. grated Velveeta"]',
                                   ARRAY ['eggs', 'milk', 'mustard', 'salt', 'onion powder', 'pepper', 'croutons']);
select cooking_camel_schema.insert('Apple Bread',
                                   '["Cream butter and sugar until fluffy.", "Beat in egg.", "Stir together flour, salt, baking soda, cinnamon, nutmeg, cloves, raisins and pecans.", "Add to sugar mixture alternately with applesauce.", "Pour into greased 9 x 5 x 3-inch loaf pan.", "Bake in 325\u00b0 oven for 1 hour or until knife inserted in center comes out clean."]',
                                   '["1/2 c. margarine or butter", "1 egg", "1 tsp. cinnamon", "1/2 tsp. ground cloves", "1/4 tsp. salt", "1/2 c. chopped pecans", "1 c. brown sugar", "1 3/4 c. flour", "1 tsp. baking soda", "1/2 tsp. ground nutmeg", "1 c. raisins", "1 1/4 c. applesauce"]',
                                   ARRAY ['margarine', 'egg', 'cinnamon', 'ground cloves', 'salt', 'pecans', 'brown sugar', 'flour', 'baking soda', 'ground nutmeg', 'raisins', 'applesauce']);
select cooking_camel_schema.insert('Homemade Noodles',
                                   '["Stir together.", "Roll out as thin as you can on floured surface (use lots of flour).", "Roll up and slice whatever width you want. Gently toss to unroll.", "Drop in your favorite boiling broth. Gently boil about 8 minutes.", "These can be frozen by spreading noodles out on floured cookie sheet.", "Put in freezer until firm. Then store in freezer bags."]',
                                   '["3 c. flour", "3 eggs", "1/2 c. water"]', ARRAY ['flour', 'eggs', 'water']);
select cooking_camel_schema.insert('Chocolate Fudge',
                                   '["Combine margarine, milk and sugar in Dutch oven.", "Place over medium", "heat", "until", "sugar\tis dissolved.", "Heat slowly to boiling. Cover and boil 5 minutes.\tTurn off heat if electric stove.", "If gas", "stove,", "turn", "warmer", "as low as possible.", "Add marshmallows. Stir", "until", "dissolved.", "Add each of chocolate, one at a", "time. Stir", "until", "melted.", "Add", "vanilla\tand nuts. Pour into 15 x 10 x 1-inch pan.", "Cut when firm.", "Makes about 5 pounds."]',
                                   '["1/2 c. margarine", "1 tall can evaporated milk", "4 c. sugar", "32 marshmallows", "4 sq. baking chocolate", "9 oz. bar milk chocolate", "12 oz. pkg. semi-sweet chocolate", "1 Tbsp. vanilla", "2 c. chopped nuts"]',
                                   ARRAY ['margarine', 'milk', 'sugar', 'marshmallows', 'baking chocolate', 'milk chocolate', 'semi-sweet chocolate', 'vanilla', 'nuts']);
select cooking_camel_schema.insert('Fruit Cake',
                                   '["Beat eggs; stir in sugar.", "Sift flour, baking powder and salt. Combine with chocolate chips, nuts and cherries.", "Fold in egg-sugar mixture.", "Pour into well-greased and floured loaf pans. Place pan of water on bottom rack of oven and loaf pans on top rack.", "Bake at 325\u00b0 for 1 to 1 1/2 hours."]',
                                   '["3 eggs", "1 1/2 c. flour", "1/4 tsp. salt", "1 c. sugar", "1/2 tsp. baking powder", "1 (6 oz.) pkg. chocolate chips", "2 c. chopped nuts", "1 c. candied cherries, halved"]',
                                   ARRAY ['eggs', 'flour', 'salt', 'sugar', 'baking powder', 'chocolate chips', 'nuts', 'candied cherries']);
select cooking_camel_schema.insert('Cranberry Scones',
                                   '["Combine softened butter or margarine, confectioners sugar and orange peel in a small bowl; blend well."]',
                                   '["1/2 c. (1 stick) softened butter or margarine", "2 Tbsp. confectioners sugar", "1 tsp. grated orange peel"]',
                                   ARRAY ['butter', 'confectioners sugar']);
select cooking_camel_schema.insert('Brownie Pie',
                                   '["Place flour, cocoa and sugar in a large mixing bowl.", "Stir to mix well.", "Add eggs, margarine, salt and vanilla.", "Beat with a whisk for about 4 minutes.", "Stir in nuts.", "Pour into a greased 8-inch pie pan and bake in preheated 325\u00b0 oven until done, about 30 to 40 minutes.", "Pie will puff up and then settle down.", "Serve slightly warm with ice cream or whipped cream.", "Makes 8 servings."]',
                                   '["1/2 c. all-purpose flour", "1/4 c. cocoa", "1 c. sugar", "2 eggs", "1/2 c. margarine at room temperature", "1/8 tsp. salt", "1 tsp. vanilla", "1/2 c. chopped nuts", "ice cream or whipped cream"]',
                                   ARRAY ['all-purpose', 'cocoa', 'sugar', 'eggs', 'margarine', 'salt', 'vanilla', 'nuts', 'cream']);
select cooking_camel_schema.insert('Cream Puff Dessert',
                                   '["Boil water and margarine.", "Then add flour.", "Let cook; then add eggs one at a time.", "Spread in a 9 x 13-inch pan, sprayed with Pam.", "Bake at 350\u00b0 for 35 minutes until brown.", "Cool.", "Mix instant pudding, milk and softened cream cheese.", "Spread on crust and top with Cool Whip.", "Drizzle with chocolate syrup.", "Chill 6 hours prior to serving."]',
                                   '["1 c. water", "1 stick margarine", "1 c. flour", "4 eggs", "3 pkg. vanilla instant pudding", "4 c. milk", "1 (8 oz.) pkg. cream cheese", "12 oz. Cool Whip", "chocolate syrup"]',
                                   ARRAY ['water', 'margarine', 'flour', 'eggs', 'vanilla instant pudding', 'milk', 'cream cheese', 'chocolate syrup']);
select cooking_camel_schema.insert('Chantilly Low-Fat',
                                   '["Line strainer with a double layer of cheesecloth.", "Place yogurt in the center and let drain for 1 hour.", "Place mandarin juice in a small pan and bring to a boil.", "Reduce heat and simmer for about 20 minutes until a very thick syrup remains.", "There should be about 2 tablespoons of syrup.", "Reserve.", "Whip the cream in a bowl with an electric mixture until it holds soft peaks.", "Place the drained yogurt in a bowl and stir in the mandarin syrup.", "Gently fold in the whipping cream with a rubber spatula.", "Makes 1 cup."]',
                                   '["1 c. nonfat plain yogurt", "1/2 c. heavy cream", "1 c. mandarin juice"]',
                                   ARRAY ['nonfat plain yogurt', 'heavy cream', 'mandarin juice']);
select cooking_camel_schema.insert('Golf Balls',
                                   '["Beat all ingredients together except peanut butter until mixture is very smooth, then add peanut butter and beat until smooth and well blended.", "Roll into balls and roll in sifted powdered sugar.", "Refrigerate.", "Makes about 100."]',
                                   '["1 c. cocoa", "1 c. butter, softened", "3 (1 lb.) boxes powdered sugar", "1 1/2 c. milk", "2 Tbsp. vanilla", "5 c. peanut butter"]',
                                   ARRAY ['cocoa', 'butter', 'powdered sugar', 'milk', 'vanilla', 'peanut butter']);
select cooking_camel_schema.insert('Crispy Herb Bread',
                                   '["In a small bowl, combine oil and garlic powder. Brush over the bread. Mix together thyme, marjoram, paprika and grated cheese. Place bread halves on a baking sheet; sprinkle with cheese and herb mixture. Bake in 425\u00b0 oven for 7 to 9 minutes, until lightly browned. Cut each half into 5 slices."]',
                                   '["4 tsp. olive oil", "1/2 tsp. garlic powder", "1 loaf French bread, halved lengthwise", "1 tsp. dried thyme", "1/4 tsp. dried marjoram", "1/2 tsp. paprika", "3 Tbsp. grated Parmesan cheese"]',
                                   ARRAY ['olive oil', 'garlic powder', 'bread', 'thyme', 'marjoram', 'paprika', 'Parmesan cheese']);
select cooking_camel_schema.insert('Festive Fruit Salad',
                                   '["Combine pineapple, oranges, grapes, strawberries and apples. Sprinkle with lemon juice.", "Add marshmallows and chill."]',
                                   '["1 (20 oz.) can pineapple chunks, drained (reserve juice)", "1 (11 oz.) can mandarin oranges", "2 c. grapes", "2 c. miniature marshmallows", "1 c. sliced strawberries", "3 c. chopped apples, peeled if desired", "2 tsp. lemon juice", "2 tsp. orange juice", "1 Tbsp. cornstarch", "1/4 c. sugar", "2 bananas, sliced", "1/2 c. nuts (pecans)"]',
                                   ARRAY ['pineapple', 'mandarin oranges', 'grapes', 'marshmallows', 'strawberries', 'apples', 'lemon juice', 'orange juice', 'cornstarch', 'sugar', 'bananas', 'nuts']);
select cooking_camel_schema.insert('Egg Custard',
                                   '["Preheat oven to 400\u00b0.", "Bake empty pie shell 5 minutes.", "Remove from oven; set aside."]',
                                   '["2 c. sugar", "5 eggs", "2 c. milk", "2 Tbsp. cornstarch", "2 1/2 tsp. vanilla", "ground cinnamon", "1 pie shell"]',
                                   ARRAY ['sugar', 'eggs', 'milk', 'cornstarch', 'vanilla', 'ground cinnamon', 'pie shell']);
select cooking_camel_schema.insert('Chicken Giblet Gravy',
                                   '["Mix first 4 ingredients in saucepan and bring to boil.", "Reduce to low-medium heat and add flour-water mixture.", "Let simmer 5 to 10 minutes over low heat."]',
                                   '["4 to 5 c. chicken broth", "3 boiled eggs, chopped", "1 c. chopped chicken", "salt and pepper to taste", "3 Tbsp. flour (self-rising)", "2 Tbsp. water"]',
                                   ARRAY ['chicken broth', 'eggs', 'chicken', 'salt', 'flour', 'water']);
select cooking_camel_schema.insert('Beef Brisket',
                                   '["Mix catsup, water, onion, vinegar, horseradish, mustard, salt and pepper.", "Place brisket, fat side up, in shallow dish.", "Cover and refrigerate several hours or overnight.", "Roast in a preheated oven at 300\u00b0 until tender (3 1/2 to 4 hours).", "Slice against the grain and serve with sauce."]',
                                   '["4 lb. beef brisket", "1 c. catsup", "1 c. water", "1/2 onion, minced", "2 Tbsp. cider vinegar", "1 Tbsp. prepared horseradish", "1 Tbsp. prepared mustard", "1 tsp. salt", "1/2 tsp. pepper"]',
                                   ARRAY ['beef brisket', 'catsup', 'water', 'onion', 'cider vinegar', 'horseradish', 'mustard', 'salt', 'pepper']);
select cooking_camel_schema.insert('Fruit Medley',
                                   '["Allow tapioca, 1 cup water and sugar to stand 5 minutes, then cook until clear.", "Add 1 1/2 cups water, orange juice, oranges and peaches.", "Chill well, even overnight.", "Before serving, add strawberries and bananas.", "(Add fruit early enough to allow flavors to blend.)", "Top with lime sherbet in fruit or sauce dishes.", "Serves 8."]',
                                   '["3 Tbsp. tapioca", "1 c. water", "1/2 c. sugar", "1 1/2 c. water", "1 (6 oz.) can frozen orange juice, thawed", "1 (11 oz.) can Mandarin oranges, drained", "1 (16 oz.) can peach slices, cut in half and drained", "1 (16 oz.) bag frozen whole strawberries, thawed", "2 large bananas", "lime sherbet"]',
                                   ARRAY ['tapioca', 'water', 'sugar', 'water', 'orange juice', 'oranges', 'peach slices', 'strawberries', 'bananas', 'lime sherbet']);
select cooking_camel_schema.insert('NanaS Cornbread(For 9-Inch Iron Skillet Or 8 X 8-Inch Pan)  ',
                                   '["Stir 1/2 teaspoon baking soda into 1 cup buttermilk.", "Melt 1/4 cup bacon fat into pan you are using in the oven you are preheating.", "Mix ingredients.", "Bake at 425\u00b0 for 20 to 25 minutes or until golden brown."]',
                                   '["1 c. corn meal", "1 c. flour", "1 to 2 Tbsp. sugar", "1/2 tsp. salt", "2 tsp. baking soda", "1 egg", "1 c. buttermilk", "1/4 c. bacon fat"]',
                                   ARRAY ['corn meal', 'flour', 'sugar', 'salt', 'baking soda', 'egg', 'buttermilk', 'bacon fat']);
select cooking_camel_schema.insert('Marinated Pork Roast',
                                   '["Combine all ingredients except roast.", "Place roast in plastic bag and set in deep bowl.", "Pour in marinade and close bag tightly. Let stand 2 to 3 hours at room temperature or overnight in refrigerator.", "Occasionally press bag against meat to distribute marinade.", "Remove meat.", "Roast, uncovered, at 325\u00b0 for 3 hours. Baste with marinade the last hour."]',
                                   '["1 (4 to 5 lb.) rolled pork roast", "1/2 c. sherry", "1 Tbsp. dry mustard", "1 tsp. thyme", "1/2 c. soy sauce", "2 minced garlic cloves", "1 tsp. ginger"]',
                                   ARRAY ['pork roast', 'sherry', 'mustard', 'thyme', 'soy sauce', 'garlic', 'ginger']);
select cooking_camel_schema.insert('DadS Chili',
                                   '["Fry pork in oil in saucepan over medium heat.", "Add minced garlic to pork.", "Dice green chilies and sprinkle with garlic salt. Drain meat.", "Add 3 cups of water.", "Add green chilies and diced tomatoes; add with garlic salt.", "Mix cornstarch to remaining cup of water.", "Then add to mixture.", "Salt to taste.", "Cook at medium heat."]',
                                   '["2 lb. pork tenderloin, cubed", "1 Tbsp. oil", "1 Tbsp. minced garlic", "6 to 10 roasted and peeled Pueblo green chilies", "1 can stewed tomatoes", "4 c. water", "3 tsp. cornstarch", "garlic salt to taste"]',
                                   ARRAY ['pork tenderloin', 'oil', 'garlic', 'green chilies', 'tomatoes', 'water', 'cornstarch', 'garlic salt']);
select cooking_camel_schema.insert('Spoon Rolls',
                                   '["Dissolve yeast in warm water.", "Mix with other ingredients.", "To bake, spoon batter into well-greased muffin tin about 2/3 full. Bake at 425\u00b0 for 20 minutes or until golden brown. Will keep in refrigerator for 2 weeks if sealed in Tupperware bowl."]',
                                   '["3/4 c. Crisco, melted", "1 egg", "1 pkg. dry yeast", "4 c. self-rising flour", "2 c. lukewarm water", "1/4 c. sugar"]',
                                   ARRAY ['egg', 'yeast', 'flour', 'water', 'sugar']);
select cooking_camel_schema.insert('Chicago Crunchy Chocolate Chip Cookies',
                                   '["Sift flour, baking soda and salt onto wax paper.", "Preheat oven to moderate (350\u00b0).", "Beat butter, margarine, brown sugar, granulated sugar, egg, milk and vanilla in a bowl until well blended."]',
                                   '["3 1/2 c. flour", "3 tsp. baking soda", "1 c. packed brown sugar", "1 Tbsp. milk", "2 Tbsp. vanilla", "1 c. cornflakes", "1 (12 oz.) pkg. chocolate pieces (semi-sweet)", "1 tsp. salt", "1/2 c. butter", "1 c. granulated sugar", "1 egg", "1 c. vegetable oil", "1 c. quick oats"]',
                                   ARRAY ['flour', 'baking soda', 'brown sugar', 'milk', 'vanilla', 'cornflakes', 'chocolate', 'salt', 'butter', 'sugar', 'egg', 'vegetable oil', 'oats']);
select cooking_camel_schema.insert('Salad Dressing', '["Place in blender until smooth."]',
                                   '["2 Tbsp. lemon juice or wine vinegar", "1 Tbsp. honey", "1 clove garlic, diced", "1 Tbsp. rosemary", "2 Tbsp. water", "1 small diced onion", "1 Tbsp. flax seed", "1 tsp. parsley"]',
                                   ARRAY ['lemon juice', 'honey', 'clove garlic', 'rosemary', 'water', 'onion', 'flax seed', 'parsley']);
select cooking_camel_schema.insert('LeroyS Heavenly Hash', '["Mix in a large bowl.", "Refrigerate and serve cold."]',
                                   '["No. 2 can fruit cocktail", "4 bananas, cut up", "1 small bag miniature marshmallows", "1 (8 oz.) pkg. pecan pieces", "1 pt. Cool Whip", "1 small can crushed pineapple"]',
                                   ARRAY ['No', 'bananas', 'marshmallows', 'pecan pieces', 'pineapple']);
select cooking_camel_schema.insert('Banana Cream Pie',
                                   '["Whisk together the milk, cream and egg yolks.", "Combine the sugar and cornstarch in heavy saucepan.", "Whisk in the yolk mixture and cook over medium heat, stirring occasionally, for 5 minutes. Then stir the mixture constantly until it comes to a boil, about 7 minutes more.", "Boil, stirring, 1 minute.", "Remove the saucepan from heat and stir in the vanilla, butter and bananas.", "Pour into baked pie shell and smooth top.", "Finish with meringue or whipped cream topping."]',
                                   '["2 1/2 c. milk", "1/4 c. heavy cream", "2 egg yolks", "2/3 c. sugar", "4 Tbsp. cornstarch", "2 tsp. vanilla", "3 Tbsp. butter (room temperature)", "1 or 2 sliced bananas"]',
                                   ARRAY ['milk', 'heavy cream', 'egg yolks', 'sugar', 'cornstarch', 'vanilla', 'butter', 'bananas']);
select cooking_camel_schema.insert('Marinated Onions And Blue Cheese',
                                   '["Mix olive oil, lemon juice, salt, pepper and sugar.", "Add Blue cheese and onions."]',
                                   '["1/2 c. olive oil", "2 tsp. lemon juice", "1 tsp. salt", "dash of pepper", "1/2 tsp. sugar", "1/4 c. crumbled Blue cheese", "2 c. sliced red or yellow onions"]',
                                   ARRAY ['olive oil', 'lemon juice', 'salt', 'pepper', 'sugar', 'cheese', 'onions']);
select cooking_camel_schema.insert('Cheese Cake',
                                   '["Grease a spring-form pan (you can use a 13 x 9-inch pan) and pat mixture of graham cracker crumbs, butter, cinnamon and 1/4 cup sugar in bottom and a little up the sides of the pan."]',
                                   '["1 1/2 c. graham cracker crumbs", "1/2 c. butter", "1/4 tsp. cinnamon", "1/4 c. sugar", "1 (16 oz.) pkg. cream cheese", "1/3 c. milk", "1/2 c. sugar", "3 eggs", "4 Tbsp. lemon juice"]',
                                   ARRAY ['graham cracker crumbs', 'butter', 'cinnamon', 'sugar', 'cream cheese', 'milk', 'sugar', 'eggs', 'lemon juice']);
select cooking_camel_schema.insert('Carrot Bread',
                                   '["Mix all ingredients in order.", "Bake in greased loaf pan for 1 hour at 350\u00b0."]',
                                   '["1 c. sugar", "2/3 c. oil", "2 eggs", "1 1/2 c. flour", "1 tsp. baking soda", "1 tsp. baking powder", "1 tsp. cinnamon", "1 jar junior strained carrots (baby food)", "1/2 c. nuts"]',
                                   ARRAY ['sugar', 'oil', 'eggs', 'flour', 'baking soda', 'baking powder', 'cinnamon', 'carrots', 'nuts']);
select cooking_camel_schema.insert('Mistletoe Punch',
                                   '["Combine all ingredients, except ginger ale and garnish, in a punch bowl.", "Just before serving, add some ice cubes and stir in the ginger ale.", "Put lemon slice and a cherry in each cup.", "Serves 30."]',
                                   '["1 (6 oz.) can frozen lemonade concentrate, thawed", "1 (6 oz.) can frozen orange juice concentrate, thawed", "6 c. water", "1/2 ??? grenadine syrup", "1 qt. ginger ale, chilled", "wafer thin lemon slices and maraschino cherries for garnish"]',
                                   ARRAY ['frozen lemonade concentrate', 'orange juice concentrate', 'water', 'grenadine syrup', 'ginger ale', 'maraschino cherries']);
select cooking_camel_schema.insert('Mixed Vegetable Casserole',
                                   '["Mix first 5 ingredients.", "Pour into casserole and top with crackers mixed with margarine.", "Bake at 350\u00b0 for 30 minutes."]',
                                   '["1 can Veg-All, drained", "1/2 c. chopped onion", "1/2 c. water chestnuts, sliced", "1/2 c. grated cheese (Cheddar)", "1/3 c. plus 2 level Tbsp. mayonnaise", "1/2 roll Ritz crackers, crushed", "1/2 stick margarine"]',
                                   ARRAY ['Veg-All', 'onion', 'water chestnuts', 'grated cheese', 'mayonnaise', 'roll', 'margarine']);
select cooking_camel_schema.insert('Cheeseburger Crescent Bake(1 Hour)  ',
                                   '["Press crescent rolls in 13 x 9-inch pan, forming crust 1/2-inch up edge.", "Brown hamburger in skillet with onion.", "Drain grease.", "Remove from heat and stir in remaining ingredients. Spread over crescent rolls.", "Bake 20 to 25 minutes at 350\u00b0.", "Kids love this!"]',
                                   '["1 lb. ground beef", "1 (8 oz.) pkg. crescent rolls", "1/8 c. chopped onion", "1 tsp. Worcestershire sauce", "1 tsp. lemon juice", "1/2 tsp. paprika", "1/4 tsp. garlic powder", "1/2 tsp. salt", "1/8 tsp. pepper", "2 c. shredded cheese", "1 beaten egg"]',
                                   ARRAY ['ground beef', 'crescent rolls', 'onion', 'Worcestershire sauce', 'lemon juice', 'paprika', 'garlic powder', 'salt', 'pepper', 'shredded cheese', 'egg']);
select cooking_camel_schema.insert('Do-Unkles Pumpkin Cake',
                                   '["Combine all ingredients together.", "Mix at medium speed for 3 minutes.", "Pour into a 9 x 13-inch pan.", "Bake at 325\u00b0 for 45 minutes.", "Frost with cream cheese frosting or your favorite."]',
                                   '["2 c. sugar", "2 c. flour", "2 c. pumpkin", "1/2 tsp. salt", "2 tsp. cinnamon", "1 tsp. nutmeg", "2 tsp. soda", "1 c. oil", "4 eggs", "2 tsp. baking powder", "1 c. chopped walnuts"]',
                                   ARRAY ['sugar', 'flour', 'pumpkin', 'salt', 'cinnamon', 'nutmeg', 'soda', 'oil', 'eggs', 'baking powder', 'walnuts']);
select cooking_camel_schema.insert('Colonial Cheese Biscuits',
                                   '["These pancakes are as big as a dinner plate and formerly even bigger (12-inches in diameter!).", "Nowadays you may find such big pancakes on the menu of a restaurant, but at home, we make them the dinner plate size.", "They are either eaten as a savory (with smoked sausage or bacon) or as a sweet (plain with molasses or golden syrup or with apples).", "Pancakes are best when made with yeast and they should be served piping hot.", "Use two skillets when available. Keep the pancakes hot on steam, or covered in the oven.", "Cold pancakes are awful!", "The following recipe is a luxury one, for special occasions, as many eggs are used in preparing (instead of yeast)."]',
                                   '["1 1/2 lb. sharp Cheddar cheese", "2 sticks butter, softened", "2 c. plus 2 Tbsp. flour", "1 1/2 tsp. salt", "1 1/2 tsp. paprika", "confectioners sugar"]',
                                   ARRAY ['Cheddar cheese', 'butter', 'flour', 'salt', 'paprika', 'confectioners sugar']);
select cooking_camel_schema.insert('Simple Salsa Dip',
                                   '["Mix it all together and microwave until cheese melts.", "Goes good with tortilla chips."]',
                                   '["1 jar (any size) salsa", "1 lb. American cheese (shredded)", "1 can refried beans"]',
                                   ARRAY ['salsa', 'American cheese', 'beans']);
select cooking_camel_schema.insert('Any Flavor Pan Dessert',
                                   '["Mix the first 4 ingredients and press into a 9 x 13-inch pan. Bake 8 to 10 minutes at 350\u00b0.", "Combine 1 cup whipped topping with cream cheese and powdered sugar.", "Spread on top of baked layer and chill.", "Mix pudding with milk and spread over second layer.", "Chill 15 minutes before spreading the remaining whipped topping over the pudding.", "Serves 16."]',
                                   '["1 c. flour", "1 stick butter or oleo", "1/2 c. chopped pecans (optional)", "1 Tbsp. sugar", "1 small container frozen whipped topping", "1 (8 oz.) pkg. cream cheese", "1 c. powdered sugar", "2 pkg. instant pudding", "3 c. milk"]',
                                   ARRAY ['flour', 'butter', 'pecans', 'sugar', 'cream cheese', 'powdered sugar', 'instant pudding', 'milk']);
select cooking_camel_schema.insert('Mexican Casserole',
                                   '["In 9 X 13 dish spree fritos or doritos to cover well.", "Brown and mix hamburger and onion.", "Add rotel, soups and milk.", "Pour over chips, cover with cheese and bake at 350 degrees until bubbly (25 to 30 minutes)."]',
                                   '["Fritos or Doritos", "1 lb. ground beef", "1 onion", "1 can rotel", "1 can mushroom soup", "1 can cream of chicken soup", "1 (12 oz.) can pet milk (can use fat free)", "Grated cheese"]',
                                   ARRAY ['Fritos', 'ground beef', 'onion', 'mushroom soup', 'cream of chicken soup', 'milk', 'cheese']);
select cooking_camel_schema.insert('Apple Sour Cream Coffee Cake',
                                   '["Combine flour, soda and salt. In another bowl, cream butter and 1 cup sugar until fluffy. Add eggs and vanilla; mix well. Blend in flour mix, alternating with sour cream. In another bowl, mix together apples, cinnamon, 1/2 cup sugar and nuts. Spread half the batter in a greased 9-inch tube or Bundt pan. Sprinkle half the cinnamon-apple mix over the batter. Spoon in the rest of the batter and sprinkle on the rest of the cinnamon-apple mix. Bake at 375\u00b0 for 40 to 50 minutes. Cool 10 minutes before removing from pan."]',
                                   '["2 c. flour", "1 tsp. baking soda", "1/2 tsp. salt", "1/2 c. butter or margarine", "1 c. sugar", "2 eggs", "1 tsp. vanilla", "1 c. sour cream", "1/2 c. sugar", "1 tsp. cinnamon", "1/2 c. chopped nuts", "1 1/4 c. apples, peeled and thinly sliced"]',
                                   ARRAY ['flour', 'baking soda', 'salt', 'butter', 'sugar', 'eggs', 'vanilla', 'sour cream', 'sugar', 'cinnamon', 'nuts', 'apples']);
select cooking_camel_schema.insert('Snickerdoodles',
                                   '["Preheat oven to 350\u00b0.", "Beat with an electric mixer, the sugar, margarine, shortening and eggs in a large mixing bowl.", "Put flour, cream of tartar, baking soda and salt into flour sifter and add to the sugar mixture.", "Stir until flour disappears.", "Shape dough by rounding teaspoonfuls into balls.", "Mix 2 teaspoons sugar and 2 teaspoons cinnamon; roll each ball in cinnamon sugar mixture. Place about 2 inches apart on cookie sheet.", "Bake until set, about 8 to 10 minutes."]',
                                   '["1 1/2 c. sugar", "1/2 c. margarine", "1/2 c. vegetable shortening", "2 eggs", "2 tsp. cinnamon", "2 3/4 c. flour", "2 tsp. cream of tartar", "1 tsp. baking soda", "1/4 tsp. salt", "2 tsp. sugar"]',
                                   ARRAY ['sugar', 'margarine', 'vegetable shortening', 'eggs', 'cinnamon', 'flour', 'cream of tartar', 'baking soda', 'salt', 'sugar']);
select cooking_camel_schema.insert('Spaghetti Salad',
                                   '["In a saucepan, cook spaghetti until tender.", "Drain and cool. In a large bowl, combine all ingredients and stir."]',
                                   '["1 lb. spaghetti", "3 cucumbers, diced", "4 tomatoes, diced", "2 stalks celery, diced", "1 green pepper, diced", "2 onions, diced", "1 small bottle Wish-Bone Italian salad dressing", "1/2 bottle Salad Supreme"]',
                                   ARRAY ['spaghetti', 'cucumbers', 'tomatoes', 'stalks celery', 'green pepper', 'onions', 'Italian salad dressing', 'Salad Supreme']);
select cooking_camel_schema.insert('Spanish Meat Balls',
                                   '["Mix well the first 9 ingredients; shape into small balls.", "Put into a large greased casserole.", "Heat soup, water and remaining chili powder; pour over meat balls.", "Bake, covered, at 375\u00b0 for 2 hours.", "Yields 6 servings."]',
                                   '["1 lb. ground meat", "2 slices cubed bread", "1 onion, grated", "1/2 c. rice (uncooked)", "1 tsp. chili powder", "1/2 tsp. allspice", "2 eggs", "1 tsp. salt", "1 green pepper (optional)", "2 cans tomato soup", "2 1/2 soup cans water", "1 tsp. chili powder"]',
                                   ARRAY ['ground meat', 'bread', 'onion', 'rice', 'chili powder', 'allspice', 'eggs', 'salt', 'green pepper', 'tomato soup', 'water', 'chili powder']);
select cooking_camel_schema.insert('Fried Onion Rings',
                                   '["Cut onions into 1/2-inch slices; separate rings. Place in a bowl; cover with ice water and let soak for 30 minutes."]',
                                   '["2 large sweet onions", "1 egg", "2/3 c. water", "1 Tbsp. vegetable oil", "1 tsp. lemon juice", "1 c. all-purpose flour", "1 1/2 tsp. baking powder", "1 to 1 1/4 tsp. salt", "1/8 to 1/4 cayenne pepper", "oil (for deep-fat frying)"]',
                                   ARRAY ['sweet onions', 'egg', 'water', 'vegetable oil', 'lemon juice', 'flour', 'baking powder', 'salt', 'cayenne pepper', 'oil']);
select cooking_camel_schema.insert('Mayonnaise Rolls',
                                   '["Mix well, fill muffin pans 1/3 full.", "Bake at 400\u00b0 until brown.", "Makes about 6 rolls."]',
                                   '["1 c. White Lily Self Rising Flour", "1/3 c. mayonnaise", "1/2 c. sweet milk", "pinch salt"]',
                                   ARRAY ['White Lily', 'mayonnaise', 'sweet milk', 'salt']);
select cooking_camel_schema.insert('Cheeseburger Loaf',
                                   '["Preheat oven to 350\u00b0.", "Combine all ingredients except cheese in bowl and mix thoroughly.", "Lightly grease a loaf pan.", "Put 1/3 of meat mixture in the bottom of pan and spread evenly.", "Put 1/2 cup cheese on top (keep cheese away from the edge of the pan to prevent burning or sticking).", "Repeat layers (1/3 meat, 1/2 cup cheese, 1/3 meat).", "Bake 1 hour.", "Let stand 10 to 15 minutes before removing to a platter to slice.", "Yield:", "6 servings. Preparation time: 30 minutes."]',
                                   '["1/2 c. evaporated milk", "1 egg", "1 c. cracker crumbs", "1 1/2 lb. ground chuck", "4 Tbsp. finely chopped onion", "1 1/2 tsp. salt or to taste", "1 tsp. dry mustard", "1 Tbsp. ketchup", "1 c. grated American cheese"]',
                                   ARRAY ['milk', 'egg', 'cracker crumbs', 'ground chuck', 'onion', 'salt', 'dry mustard', 'ketchup', 'American cheese']);
select cooking_camel_schema.insert('One Bowl Chocolate Fudge(Microwave)  ',
                                   '["Microwave chocolate and milk in 1 1/2-quart microwavable bowl on High 1 minute; stir well.", "Microwave 1 minute longer. Stir until chocolate is completely melted and smooth.", "Stir in vanilla, salt and walnuts.", "Spread into greased 9 x 5-inch loaf pan. Refrigerate 30 minutes or until firm.", "Cut into squares."]',
                                   '["1 pkg. (8 oz.) semi-sweet chocolate", "2/3 c. sweetened condensed milk", "1 tsp. vanilla", "1/8 tsp. salt", "1 c. chopped nuts"]',
                                   ARRAY ['semi-sweet chocolate', 'condensed milk', 'vanilla', 'salt', 'nuts']);
select cooking_camel_schema.insert('Ranch Style Baked Beans Casserole',
                                   '["Brown meat in margarine; stir in remaining ingredients.", "Pour into bean pot or 2-quart casserole (cool and freeze if desired.) Bake at 400\u00b0 for 30 minutes.", "Makes 10 to 12 servings."]',
                                   '["2 Tbsp. margarine", "1 lb. ground beef", "1 pkg. onion soup mix", "1/2 c. water", "1 c. catsup", "2 Tbsp. prepared mustard", "2 tsp. vinegar", "2 (1 lb.) cans pork and beans in tomato sauce", "1 (1 lb.) can kidney beans, drained"]',
                                   ARRAY ['margarine', 'ground beef', 'onion soup mix', 'water', 'catsup', 'mustard', 'vinegar', 'pork', 'kidney beans']);
select cooking_camel_schema.insert('EttaS Hungarian Coffee Cake',
                                   '["Mix sugar and shortening.", "Add flour and salt until it crumbles.", "Put aside 1/2 cup of this mixture for topping.", "Add egg to remainder.", "Add soda and baking powder to sour milk, then mix everything together.", "Sprinkle crumbs on top.", "(Optional: Sprinkle cinnamon and ground nuts on top.)", "Bake for 35 minutes in a 9-inch cake pan or pie plate."]',
                                   '["1 c. brown sugar", "1 c. flour", "1/3 c. shortening", "pinch of salt", "1 egg, beaten", "1 tsp. baking soda", "1/2 tsp. baking powder", "1/2 c. sour milk (add 1 Tbsp. vinegar or lemon juice to sour 1 c. milk)"]',
                                   ARRAY ['brown sugar', 'flour', 'shortening', 'salt', 'egg', 'baking soda', 'baking powder', 'sour milk']);
select cooking_camel_schema.insert('Beer Biscuits',
                                   '["Dissolve sugar in beer and add to biscuit mix.", "Mix and bake in accordance with directions on biscuit mix container."]',
                                   '["2 c. biscuit mix", "1 1/2 Tbsp. sugar", "6 oz. warm beer"]',
                                   ARRAY ['biscuit mix', 'sugar', 'warm beer']);
select cooking_camel_schema.insert('Baked Spaghetti',
                                   '["In a large skillet, saute onion and green pepper in butter until tender.", "Add tomatoes, mushrooms, olives and oregano.", "Add ground beef if desired.", "Simmer uncovered for 10 minutes.", "Place half of the spaghetti in a greased 13 x 9 x 2-inch baking dish. Top with half of the vegetable mixture.", "Sprinkle with 1 cup Cheddar cheese.", "Repeat layers."]',
                                   '["1 c. chopped onion", "1 c. chopped green pepper", "1 Tbsp. butter", "1 (28 oz.) can tomatoes with liquid, cut up", "1 (4 oz.) can mushroom stems and pieces, drained", "1 (2 1/4 oz.) can sliced ripe olives, drained", "2 tsp. dried oregano", "1 lb. ground beef, browned and drained (optional)", "12 oz. spaghetti, cooked and drained", "2 c. (8 oz.) shredded Cheddar cheese", "1 (10 3/4 oz.) can condensed cream of mushroom soup (undiluted)", "1/4 c. water", "1/4 c. grated Parmesan cheese"]',
                                   ARRAY ['onion', 'green pepper', 'butter', 'tomatoes', 'mushroom stems', 'olives', 'oregano', 'ground beef', 'Cheddar cheese', 'condensed cream', 'water', 'Parmesan cheese']);
select cooking_camel_schema.insert('Easy Apple Dumplings',
                                   '["Peel, cut apples into quarters.", "Roll out biscuits.", "Cut each in half.", "Put 1 quarter apple in each biscuit half.", "Fold dough over apple, place in a buttered sheet pan or large casserole dish. Mix next 5 ingredients; pour over dumplings, cut butter over top. Bake in a 350\u00b0 oven until apples are done.", "Take from oven, baste and continue baking until golden brown.", "May be served with Cool Whip.", "Yields 8 to 10 portions."]',
                                   '["1 can biscuits (10 count)", "5 cooking apples", "1/2 c. granulated sugar", "1/2 c. brown sugar", "1 1/2 c. water", "1 tsp. apple pie spice", "1 tsp. vanilla", "1 stick butter or margarine"]',
                                   ARRAY ['cooking apples', 'sugar', 'brown sugar', 'water', 'apple pie spice', 'vanilla', 'butter']);
select cooking_camel_schema.insert('Twinkie Dessert',
                                   '["Line bottom of 13x9 pan with Twinkies.", "Mix jello with hot water and stir until dissolved. Add strawberries and pour over Twinkies.", "Let set for 30 minutes or more.", "Mix pudding as directed and pour over Twinkies and jello.", "Cover with Cool Whip and decorate with more strawberries if desired."]',
                                   '["14 Twinkies", "1 large box strawberry jello", "2 c. hot water", "1 10 oz. frozen strawberries or 2 c. fresh", "1 large box vanilla instant pudding", "1 large container Cool Whip"]',
                                   ARRAY ['Twinkies', 'strawberry jello', 'water', 'frozen strawberries', 'vanilla instant pudding']);
select cooking_camel_schema.insert('Gooey Butter Cake',
                                   '["Preheat oven at 350\u00b0.", "Mix cake mix with 1 egg and butter, melted.", "Press into a 9 x 12 cake pan that has been greased and floured.", "Then mix 2 eggs, cream cheese, 1 box powdered sugar and vanilla together.", "Use a blender until all mixed, then pour over cake in pan and bake about 35 to 40 minutes at 350\u00b0 or until you can stick a toothpick in and it comes out clean.", "Cool, then cut into squares and eat."]',
                                   '["1 box yellow or chocolate cake mix", "3 eggs", "1 stick butter", "1 (8 oz.) cream cheese", "1 box powdered sugar", "1 tsp. vanilla"]',
                                   ARRAY ['chocolate cake', 'eggs', 'butter', 'cream cheese', 'powdered sugar', 'vanilla']);
select cooking_camel_schema.insert('Corn Pudding',
                                   '["Mix flour, sugar, salt and pepper.", "Add to corn.", "Add melted butter. Add eggs.", "Add milk.", "Pour into greased casserole.", "Place in a pan of water. Bake at 325\u00b0 for 1 hour.", "Serves 6."]',
                                   '["1 (1 lb.) can cream-style corn", "1 Tbsp. butter", "1 Tbsp. flour", "4 eggs, well beaten", "3 Tbsp. sugar", "1 c. scalded milk", "1 tsp. salt", "1/8 tsp. pepper"]',
                                   ARRAY ['cream-style', 'butter', 'flour', 'eggs', 'sugar', 'milk', 'salt', 'pepper']);
select cooking_camel_schema.insert('Honey Cake',
                                   '["Preheat oven to 325\u00b0.", "Grease and flour a 9 x 13-inch cake pan.", "In a large mixing bowl, beat eggs and honey together.", "Add sugar and mix again.", "Mix coffee with baking powder and add margarine to the egg mixture.", "Add baking soda, flour and cinnamon and beat together well.", "Pour into greased cake pan.", "Bake for 55 minutes to 1 hour."]',
                                   '["3 eggs", "??? c. honey", "1/2 c. sugar", "1 c. strong black coffee", "2 tsp. baking powder", "3 Tbsp. soft margarine", "1 tsp. baking soda", "4 c. flour", "1 tsp. cinnamon"]',
                                   ARRAY ['eggs', 'honey', 'sugar', 'black coffee', 'baking powder', 'margarine', 'baking soda', 'flour', 'cinnamon']);
select cooking_camel_schema.insert('Enchiladas',
                                   '["In a saucepan, combine tomato paste, water, garlic and chili powder; simmer 20 minutes.", "In skillet, brown ground beef with half of the onions; drain fat.", "Stir in 1 1/2 cups of cheese and 1 cup tomato paste mixture.", "Spoon 1/4 cup tomato paste mixture in 3-quart shallow baking dish.", "Soften tortillas, one at a time, by dipping in and out of remaining mixture.", "Spoon beef mixture down center of each tortilla; roll up.", "Place seam side down in baking dish.", "Pour remaining tomato paste mixture over top.", "Sprinkle with remaining cheese and onions.", "Bake at 350\u00b0 for 20 minutes. Makes 6 servings."]',
                                   '["1 (12 oz.) can tomato paste", "1 qt. water", "2 cloves garlic, minced", "5 tsp. chili powder", "1 lb. lean ground beef", "1/2 c. chopped green onions", "2 c. shredded Monterey Jack cheese", "1 doz. corn tortillas"]',
                                   ARRAY ['tomato paste', 'water', 'garlic', 'chili powder', 'lean ground beef', 'green onions', 'shredded Monterey Jack cheese', 'corn tortillas']);
select cooking_camel_schema.insert('Zucchini In Tomato Juice(From Weight Watchers)  ',
                                   '["Cut zucchini in half lengthwise, then cut into cubes.", "Put all ingredients in a saucepan and cook until the zucchini is tender."]',
                                   '["zucchini", "12 oz. tomato juice", "dash of oregano", "dash of parsley flakes", "dash of garlic powder", "2 Tbsp. bell pepper", "2 Tbsp. dehydrated onions", "salt", "1 chicken bouillon cube"]',
                                   ARRAY ['zucchini', 'tomato juice', 'oregano', 'parsley flakes', 'garlic', 'bell pepper', 'onions', 'salt', 'chicken']);
select cooking_camel_schema.insert('Pineapple Casserole',
                                   '["Mix sugar, flour and cheese.", "Add pineapple; pour in greased 10 x 10-inch casserole.", "Sprinkle crackers on top.", "Pour melted butter over top.", "Bake at 350\u00b0 for 30 minutes."]',
                                   '["1 c. sugar", "6 Tbsp. flour", "2 c. grated Cheddar cheese", "1 1/2 c. crushed Ritz crackers", "2 (15 1/2 oz.) cans pineapple chunks, drained", "1 stick margarine, melted"]',
                                   ARRAY ['sugar', 'flour', 'Cheddar cheese', 'crackers', 'pineapple', 'margarine']);
select cooking_camel_schema.insert('Brunswick Stew',
                                   '["Bring chicken to boil in salted water.", "Reduce heat and simmer 1 hour, until tender.", "Remove from both.", "Add vegetables to broth and simmer until tender.", "Strip chicken from bones in large pieces and add to stew last 5 minutes of cooking."]',
                                   '["1 (2 lb.) chicken", "3 c. water", "1 1/2 tsp. salt", "3 potatoes", "1 onion", "1 (10 oz.) box frozen limas", "1 c. frozen or 1 can corn", "1 can tomatoes", "salt and pepper to taste", "1/4 c. butter"]',
                                   ARRAY ['chicken', 'water', 'salt', 'potatoes', 'onion', 'frozen limas', 'corn', 'tomatoes', 'salt', 'butter']);
select cooking_camel_schema.insert('Marinated Carrots',
                                   '["Wash and scrape carrots. Cut in diagonal slices. Cook and drain. Cool. Combine carrots with raw onion rings in a bowl. Combine tomato soup, sugar, oil, vinegar, salt and pepper in saucepan.", "Bring to boiling point; stir to dissolve sugar.", "Pour hot mixture over vegetables and mix together.", "Cover and chill in refrigerator overnight."]',
                                   '["2 lb. carrots, cut in diagonal slices", "1 large onion, sliced in rings", "1 (10 oz.) can tomato soup, undiluted", "1/2 tsp. salt", "1/2 tsp. pepper", "1 c. sugar", "1/2 c. salad oil", "3/4 c. vinegar"]',
                                   ARRAY ['carrots', 'onion', 'tomato soup', 'salt', 'pepper', 'sugar', 'salad oil', 'vinegar']);
select cooking_camel_schema.insert('Blueberry Cake',
                                   '["Beat egg whites until stiff; add 1 cup sugar.", "Set aside. Cream the shortening, salt, rest of sugar and vanilla.", "Add egg yolks.", "Beat until creamy.", "Add baking powder, milk and flour to mixture alternately.", "Fold in egg whites, then blueberries.", "Pour into a well-greased and floured 9 x 13-inch pan.", "Sugar the top. Bake at 350\u00b0 for 50 minutes."]',
                                   '["4 eggs, separated", "2 c. sugar", "1 c. shortening", "1 tsp. salt", "2 tsp. baking powder", "2 tsp. vanilla", "3 c. flour", "2/3 c. milk", "3 c. floured blueberries"]',
                                   ARRAY ['eggs', 'sugar', 'shortening', 'salt', 'baking powder', 'vanilla', 'flour', 'milk', 'floured blueberries']);
select cooking_camel_schema.insert('Summer Squash Casserole',
                                   '["Cook squash and onion (in pot with just enough water to coat bottom or steam them),", "drain and set aside. Mix the soup (do not add water) with the sour cream; combine with", "squash and onion. Melt butter and combine with stuffing. Put layer of stuffing along bottom of 6 X 10 inch baking dish. Alternate layers of squash and stuffing ending with stuffing. Bake at 350\u00b0 for 20-25 minutes."]',
                                   '["6 c. sliced yellow squash", "1 c. finely chopped onion", "1 can cream of chicken soup", "8 oz. sour cream", "8 oz. pkg. stuffing mix", "1 stick butter"]',
                                   ARRAY ['onion', 'cream of chicken soup', 'sour cream', 'stuffing mix', 'butter']);
select cooking_camel_schema.insert('Skor Cake',
                                   '["Make cake according to directions on box and bake in 9 x 13-inch pan.", "Immediately after removing from oven, poke holes all over cake and pour Eagle Brand milk and caramel sauce over top of cake.", "Allow cake to completely cool and then ice with Cool Whip. Crush Skor candy bars and sprinkle over cake.", "Keep refrigerated."]',
                                   '["1 box German chocolate cake mix", "1 can Eagle Brand condensed milk", "1 jar Smuckers caramel sauce", "1 container Cool Whip", "6 Skor candy bars"]',
                                   ARRAY ['chocolate cake', 'milk', 'caramel sauce']);
select cooking_camel_schema.insert('Never Fail Pie Crust(Double Pie Crust)  ',
                                   '["Combine flour, sugar and salt.", "Put shortening in a chilled bowl and add flour mixture.", "Blend with pastry blender to a coarse meal.", "Blend egg and ice cold water together, then add vinegar and blend.", "Add to flour mixture and mix well.", "Roll out on floured surface."]',
                                   '["4 c. sifted flour", "1 1/2 c. shortening", "1 egg", "1/2 c. ice cold water", "1 Tbsp. vinegar", "1 tsp. sugar", "1/2 tsp. salt"]',
                                   ARRAY ['flour', 'shortening', 'egg', 'water', 'vinegar', 'sugar', 'salt']);
select cooking_camel_schema.insert('Best Brownies',
                                   '["Preheat oven to 350\u00b0.", "Melt the butter.", "Pour into mixing bowl.", "Beat in cocoa and sugar.", "When mixture is smooth, beat in eggs, one at a time, then add vanilla.", "Stir in flour, salt and coconut.", "Pour in a 9 x 13-inch greased pan.", "Bake for 25 minutes. Let cool in pan and cut into squares.", "Yields about 30 bars."]',
                                   '["1/4 lb. butter", "1/2 c. cocoa", "2 c. sugar", "4 eggs", "2 tsp. vanilla", "1 1/2 c. flour", "1/4 tsp. salt", "1 c. flaked coconut"]',
                                   ARRAY ['butter', 'cocoa', 'sugar', 'eggs', 'vanilla', 'flour', 'salt', 'flaked coconut']);
select cooking_camel_schema.insert('Mushroom Caps Stuffed',
                                   '["Fry and chop stems; drain.", "Fry and drain sausage.", "Mix cheese and bread crumbs and add mushroom stems and cooked sausage.", "Mix all ingredients together.", "Fill hollowed out mushroom caps with mixture.", "Put in shallow baking dish.", "Add a little wine.", "Bake at 400\u00b0 for 15 to 20 minutes until cheese is melted.", "Serve immediately."]',
                                   '["20 to 24 white large mushrooms, cut off stems and hollow out carefully, reserving stems", "1 lb. sweet sausage", "3/4 c. Mozzarella cheese", "1/2 c. seasoned bread crumbs"]',
                                   ARRAY ['mushrooms', 'sweet sausage', 'Mozzarella cheese', 'bread crumbs']);
select cooking_camel_schema.insert('Toffee Brickle',
                                   '["Line bottom of\tlasagne", "size", "pan", "with soda crackers. Boil sugar and", "butter", "about", "8 minutes.", "Pour over crackers. Bake at 350\u00b0", "for 15 minutes.", "Remove and sprinkle with chocolate chips. Spread melted chocolate chips with a knife.", "Cool and crack into pieces.", "Store in an airtight container."]',
                                   '["unsalted soda crackers", "3/4 c. packed brown sugar", "2 sticks butter", "12 oz. bag chocolate chips"]',
                                   ARRAY ['unsalted soda crackers', 'brown sugar', 'butter', 'chocolate chips']);
select cooking_camel_schema.insert('Stir Fried Veggies Medley',
                                   '["Cut carrots and celery into thin strips.", "Thinly slice onions. Cut broccoli into 2 X 1/2 inch pieces. Cut mushrooms into quarters or in half if they are small.", "In five-quart or 12 inch skillet over high heat, in hot oil, cook vegies, stirring quickly and frequently, about 3 or 4 minutes.", "Add mushrooms, water, salt and sugar.\tOther spices may be added.", "Cover and cook 5 to 6 minutes longer until veggies are tender-crisp, stirring occasionally."]',
                                   '["2 medium carrots", "2 celery stalks", "1 medium or 2 small onions", "1 medium bunch broccoli", "1/2 lb. mushrooms", "1/4 c. salad or olive oil", "1/4 c. water", "1 1/4 tsp. salt", "1/2 tsp. pepper", "1 level tsp. sugar"]',
                                   ARRAY ['carrots', 'celery stalks', 'onions', 'broccoli', 'mushrooms', 'salad', 'water', 'salt', 'pepper', 'sugar']);
select cooking_camel_schema.insert('Bacon And Egg Breakfast Bake',
                                   '["Preheat oven to 450\u00b0.", "Spread bacon in bottom of 9-inch pie plate.", "Sprinkle with cheese.", "Beat eggs with milk and pepper. Pour over cheese.", "Bake for 15 minutes.", "Reduce heat to 350\u00b0. Bake for 10 to 15 minutes longer, until browned and firm in center.", "Place pie plate on wire rack to cool for 10 minutes.", "Cut in wedges.", "Yields 10 servings, 249 calories per serving."]',
                                   '["4 oz. fully cooked Canadian bacon or ham, cut into small cubes", "1/2 c. finely chopped Muenster, Cheddar or Monterey Jack cheese", "4 eggs", "1 1/2 c. skim milk", "1/2 tsp. pepper"]',
                                   ARRAY ['fully cooked Canadian bacon', 'Muenster', 'eggs', 'milk', 'pepper']);
select cooking_camel_schema.insert('Spiced Tea',
                                   '["Mix all ingredients.", "Use 3 to 4 teaspoons of mix for mug of hot water."]',
                                   '["1 1/4 c. Tang", "1/2 c. sugar", "1/3 c. instant tea", "1/2 tsp. cinnamon", "1/4 tsp. cloves", "dash of salt"]',
                                   ARRAY ['sugar', 'instant tea', 'cinnamon', 'cloves', 'salt']);
select cooking_camel_schema.insert('Ham Roll-Ups',
                                   '["Place ham slices, one on top of the other, on cutting board. Cut 1/2-inch strips lengthwise; do not separate.", "Combine cheese and onion.", "Spread thin layer on top of first slice of ham.", "Roll up first strips of slice and repeat next slice, etc.", "Makes 30 roll-ups."]',
                                   '["6 thin slices Prosciutto ham", "3 oz. soft cream cheese", "1 small finely chopped onion"]',
                                   ARRAY ['ham', 'cream cheese', 'onion']);
select cooking_camel_schema.insert('Pineapple Souffle',
                                   '["Melt butter in pan (9 x 9-inch).", "Mix together the next 5 ingredients and pour into baking dish with melted butter. Sprinkle with cinnamon, 1 tablespoon sugar and roasted pecans. Bake at 300\u00b0 for 40 minutes."]',
                                   '["1/4 c. butter", "1 1/2 c. sugar", "1 large can pineapple, drained", "3 slices bread, cubed", "3 eggs, beaten", "1/4 c. milk", "cinnamon", "1 Tbsp. sugar", "roasted pecans"]',
                                   ARRAY ['butter', 'sugar', 'pineapple', 'bread', 'eggs', 'milk', 'cinnamon', 'sugar', 'pecans']);
select cooking_camel_schema.insert('Real Whipped Cream That Keeps',
                                   '["In small ovenproof bowl, spread gelatin over water. Set bowl in a saucepan of hot water. Let stand until gelatin dissolves. Remove from saucepan. Let cool 1 minute. Whip cream until almost stiff. Add gelatin, salt and vanilla. Continue to whip until stiff. Makes 2 1/2 cups."]',
                                   '["1/2 tsp. unflavored gelatin", "4 tsp. cold water", "1 c. heavy cream", "pinch of salt", "1/2 tsp. real vanilla", "1 tsp. sugar"]',
                                   ARRAY ['unflavored gelatin', 'cold water', 'heavy cream', 'salt', 'vanilla', 'sugar']);
select cooking_camel_schema.insert('Montana Mud Cake',
                                   '["Cream first 3 ingredients.", "Add eggs and vanilla.", "Add flour, then add coconut and pecans.", "Mix well.", "Bake in floured and greased 9 x 12-inch pan in 350\u00b0 oven for 30 minutes.", "Pour a jar of marshmallow cream over cake and top with frosting."]',
                                   '["2 sticks margarine", "2 c. sugar", "2 Tbsp. cocoa", "4 eggs", "1 tsp. vanilla", "1 1/2 c. flour", "1 1/3 c. coconut", "1 c. chopped pecans"]',
                                   ARRAY ['margarine', 'sugar', 'cocoa', 'eggs', 'vanilla', 'flour', 'coconut', 'pecans']);
select cooking_camel_schema.insert('DianeS Quick Quiche',
                                   '["To make a grilled cheese sandwich properly you must first decide what kind of bread to use, white, wheat, rye or raisin..raisin?", "Then consider the kind of cheese you have available, American, Swiss, Cheddar, Limburger..Limburger?", "You will also need butter, or oleo, or lard.. lard?", "A kitchen countertop will be useful, as well as a knife, spatula, an iron skillet with a lid or cover, a stove and a helper to clean up the mess when you are through."]',
                                   '["3 eggs", "1 1/2 c. margarine, melted", "1/2 c. Bisquick", "1/4 tsp. salt", "pepper to taste", "1 c. shredded Swiss cheese", "1/2 c. crisp fried bacon, crumbled", "1/4 c. chopped onion", "pinch of basil", "pinch of marjoram", "1 c. broccoli or favorite vegetable"]',
                                   ARRAY ['eggs', 'margarine', 'Bisquick', 'salt', 'pepper', 'Swiss cheese', 'crisp fried bacon', 'onion', 'basil', 'marjoram', 'broccoli']);
select cooking_camel_schema.insert('Egg Drop Soup',
                                   '["In a large saucepan or Dutch oven, heat oil over medium heat. Add onion, garlic, ginger and pork; cook and stir until tender. Stir in broth, soy sauce, pepper and sesame oil; bring to a boil. Add carrots; simmer 15 minutes.", "Add all remaining ingredients except eggs; bring to a boil.", "Reduce heat to low.", "Stir in eggs with a fork to separate into strands."]',
                                   '["2 Tbsp. peanut oil", "1 c. chopped onion", "1 1/2 tsp. minced garlic", "7 c. chicken broth", "2 Tbsp. soy sauce", "1/4 tsp. pepper", "1 c. thinly sliced carrots", "1 tsp. minced ginger root", "1 lb. lean pork, cut in strips", "1 (8 oz.) can bamboo shoots, drained", "1 (8 oz.) can sliced water chestnuts, drained", "6 oz. frozen pea pods", "1/4 tsp. sesame oil", "2 eggs, well beaten"]',
                                   ARRAY ['peanut oil', 'onion', 'garlic', 'chicken broth', 'soy sauce', 'pepper', 'carrots', 'ginger root', 'lean pork', 'bamboo shoots', 'water chestnuts', 'frozen pea pods', 'sesame oil', 'eggs']);
select cooking_camel_schema.insert('Summer Berry Sauce',
                                   '["In a large bowl, combine juice concentrate and honey.", "Add fruit. Toss gently to combine.", "Store in refrigerator.", "Makes 3 cups."]',
                                   '["3/4 c. frozen raspberry or raspberry blend juice concentrate, thawed", "2 Tbsp. honey", "1 c. sliced fresh strawberries", "1 c. fresh or frozen blueberries, partially thawed", "1 c. fresh or frozen raspberries, partially thawed"]',
                                   ARRAY ['frozen raspberry', 'honey', 'fresh strawberries', 'blueberries', 'frozen raspberries']);
select cooking_camel_schema.insert('Cherry Pie',
                                   '["Cream cheese should be close to room temperature.", "Blend milk, lemon juice and vanilla with cream cheese and pour into pie crust. Chill about 2 hours.", "Then pour cherry pie filling on top.", "Chill one more hour.", "Keep refrigerated."]',
                                   '["9-inch graham cracker crust", "1 can condensed milk", "1/3 c. lemon juice", "1 can cherry pie filling", "1 (8 oz.) pkg. cream cheese", "1 tsp. vanilla"]',
                                   ARRAY ['graham cracker crust', 'condensed milk', 'lemon juice', 'cherry pie filling', 'cream cheese', 'vanilla']);
select cooking_camel_schema.insert('Baked Bean Casserole',
                                   '["Cook at 350\u00b0 for 1 3/4 hours in a 2-quart casserole."]',
                                   '["4 Tbsp. bacon drippings", "3 Tbsp. garlic salt", "3 medium onions, sliced", "1 large can pork and beans", "1 regular can red kidney beans", "1 can small green lima beans", "1/2 c. catsup", "1 tsp. dry mustard", "1/2 tsp. black pepper", "1 tsp. salt", "1/2 c. brown sugar", "1/4 c. vinegar"]',
                                   ARRAY ['bacon drippings', 'garlic salt', 'onions', 'pork', 'regular', 'beans', 'catsup', 'dry mustard', 'black pepper', 'salt', 'brown sugar', 'vinegar']);
select cooking_camel_schema.insert('Pumpkin Bread',
                                   '["Mix all ingredients together in a large bowl.", "Pour into 2 greased loaf pans.", "Bake at 350\u00b0 for at least 1 1/4 hours.", "Makes 2 loaves."]',
                                   '["2 c. canned pumpkin", "1 c. salad oil", "3 c. sugar", "3 1/4 c. flour", "4 eggs, beaten", "2 tsp. salt", "1 tsp. baking powder", "1 tsp. baking soda", "1 tsp. cinnamon", "1 tsp. cloves", "1 tsp. nutmeg"]',
                                   ARRAY ['pumpkin', 'salad oil', 'sugar', 'flour', 'eggs', 'salt', 'baking powder', 'baking soda', 'cinnamon', 'cloves', 'nutmeg']);
select cooking_camel_schema.insert('Fried Rice',
                                   '["Cook and stir", "onions", "and", "green", "pepper", "in oil until onion is tender.\tStir in rice, mushrooms and soy sauce.\tCook over low heat", "for", "10", "minutes,", "stirring frequently, stir in beaten eggs. Cook and stir 2 to 3 minutes longer."]',
                                   '["1/4 c. onions, chopped", "2 Tbsp. green pepper, chopped", "2 Tbsp. salad oil", "2 c. cooked rice", "3 oz. sliced mushrooms", "2 Tbsp. soy sauce", "3 eggs, beaten"]',
                                   ARRAY ['onions', 'green pepper', 'salad oil', 'rice', 'mushrooms', 'soy sauce', 'eggs']);
select cooking_camel_schema.insert('Paw PawS Pancakes',
                                   '["Beat eggs.", "Add sugar and mix well.", "Stir in flour and milk. Beat until smooth.", "Add melted oleo and stir thoroughly.", "Add vanilla.", "Pour onto preheated skillet or griddle.", "Turn when bubbles appear."]',
                                   '["2 eggs", "1 1/2 Tbsp. sugar", "1 1/2 c. self-rising flour", "1 c. milk", "3 to 4 Tbsp. oleo, melted", "vanilla to taste"]',
                                   ARRAY ['eggs', 'sugar', 'flour', 'milk', 'oleo', 'vanilla']);
select cooking_camel_schema.insert('Speedy White Clam Sauce',
                                   '["Drain clams.", "Heat olive oil in skillet.", "Add garlic; brown lightly.", "Add parsley and seasoning.", "Heat 2 minutes.", "Serve over cooked spaghetti."]',
                                   '["1 can minced clams", "2 cloves garlic, minced", "1/2 c. olive oil", "1 Tbsp. minced parsley", "salt and pepper"]',
                                   ARRAY ['clams', 'garlic', 'olive oil', 'parsley', 'salt']);
select cooking_camel_schema.insert('Pineapple Cranberry Pie',
                                   '["Cook fruit until cranberries burst.", "Cranberries on bottom. Blend dry ingredients and stir into fruit.", "Cook until thickened. Cool slightly and pour into 9-inch uncooked pie shell and bake at 350\u00b0", "for 30 minutes."]',
                                   '["3 c. cranberries", "1 1/2 c. crushed pineapple", "1 1/4 c. sugar", "1 Tbsp. flour", "3/4 tsp. cinnamon", "1/2 tsp. nutmeg", "1/4 tsp. salt"]',
                                   ARRAY ['cranberries', 'pineapple', 'sugar', 'flour', 'cinnamon', 'nutmeg', 'salt']);
select cooking_camel_schema.insert('Strawberry Yum-Yum',
                                   '["Melt margarine and stir in crumbs.", "Place half of mixture in bottom of baking dish.", "Whip Dream Whip and cream cheese with sugar and cold milk.", "Pour half of the Dream Whip mixture on crumbs.", "Spread strawberries on creamed mixture.", "Spread remainder of creamed mixture on top of strawberries.", "Sprinkle remainder of crumbs on top.", "Chill 3 hours or longer."]',
                                   '["1 stick margarine", "2 c. graham cracker crumbs", "2 pkg. Dream Whip", "1 (8 oz.) pkg. cream cheese", "1 c. sugar", "1 c. cold milk", "2 c. strawberries"]',
                                   ARRAY ['margarine', 'graham cracker crumbs', 'Dream Whip', 'cream cheese', 'sugar', 'cold milk', 'strawberries']);
select cooking_camel_schema.insert('Blueberry Cream Pie',
                                   '["Combine first 6 ingredients; beat 5 minutes at medium speed of an electric mixer or until smooth.", "Fold in blueberries.", "Pour filling into pastry shell.", "Bake at 400\u00b0 for 25 minutes."]',
                                   '["1 c. commerical sour cream", "2 Tbsp. all-purpose flour", "3/4 c. sugar", "1 tsp. vanilla extract", "3/4 tsp. salt", "1 egg, beaten", "2 1/2 c. fresh blueberries", "1 unbaked 9-inch pastry shell", "3 Tbsp. all-purpose flour", "3 Tbsp. butter, softened", "3 Tbsp. chopped black walnuts"]',
                                   ARRAY ['commerical sour cream', 'flour', 'sugar', 'vanilla extract', 'salt', 'egg', 'fresh blueberries', 'pastry shell', 'flour', 'butter', 'black walnuts']);
select cooking_camel_schema.insert('Western Style Barbecue',
                                   '["In saucepan, brown frankfurters in butter.", "Add remaining ingredients.", "Heat; stir occasionally.", "Garnish with green pepper rings.", "Makes about 5 cups."]',
                                   '["4 frankfurters, cut in 1-inch pieces", "2 Tbsp. butter", "1 (19 1/4 oz.) can Campbells chunky old fashioned beans with ham soup", "1 (12 oz.) can whole kernel golden corn with sweet peppers, drained", "1 (8 oz.) can lima beans, drained", "1/2 c. barbecue sauce"]',
                                   ARRAY ['frankfurters', 'butter', 'Campbells chunky', 'whole kernel golden corn', 'lima beans', 'barbecue sauce']);
select cooking_camel_schema.insert('Cheese Cake',
                                   '["Mix first 3 ingredients.", "Mix next 4 ingredients.", "Whip Milnot until stiff.", "Roll graham crackers and mix with 1 stick of oleo. Press crackers (half) into bottom of pan.", "Combine the cream cheese mixture into the Jell-O mixture and fold in the Milnot. Put on top of graham crackers.", "Add remaining crackers on top. Chill several hours."]',
                                   '["1 pkg. lemon Jell-O", "1 c. boiling water", "3 Tbsp. lemon juice", "1 (8 oz.) pkg. cream cheese", "1 c. sugar", "1 small can drained, crushed pineapple", "2 tsp. vanilla", "1 large can Milnot", "2 pkg. graham crackers", "1/2 c. oleo (1 stick)"]',
                                   ARRAY ['lemon Jell-O', 'boiling water', 'lemon juice', 'cream cheese', 'sugar', 'pineapple', 'vanilla', 'graham crackers', 'oleo']);
select cooking_camel_schema.insert('Angel Food Cake',
                                   '["Sift of sugar with flour 4 times.", "Beat whites to a foam.", "Add cream of tartar and salt and beat till it holds up peaks.", "Add remaining sugar and flavoring.", "Fold in flour."]',
                                   '["1 cup sifted cake flour", "1 1/2 cups sugar", "1 1/2 cups egg white (about a dozen)", "1 1/2 tsp. cream of tartar", "3/4 tsp. salt", "1 tsp. vanilla", "1/2 tsp. almond flavoring"]',
                                   ARRAY ['cake flour', 'sugar', 'egg white', 'cream of tartar', 'salt', 'vanilla', 'almond flavoring']);
select cooking_camel_schema.insert('Plum Nutty Cake',
                                   '["Mix all ingredients together.", "When fluffy, cook at 300\u00b0 for 1 hour or until done."]',
                                   '["2 c. self-rising flour", "2 c. sugar", "1 c. oil", "2 jars strained plum baby food", "3 eggs", "1 tsp. cinnamon", "1 tsp. allspice", "1 c. pecans, broken into small pieces"]',
                                   ARRAY ['flour', 'sugar', 'oil', 'baby food', 'eggs', 'cinnamon', 'allspice', 'pecans']);
select cooking_camel_schema.insert('Pinto Bean Pie',
                                   '["Mix all ingredients; pour into 3 unbaked pie shells.", "Bake at 350\u00b0 for 35 minutes."]',
                                   '["3 c. sugar", "2 sticks margarine, melted", "1 c. pinto beans, mashed", "4 beaten eggs", "1 Tbsp. vanilla"]',
                                   ARRAY ['sugar', 'margarine', 'pinto beans', 'eggs', 'vanilla']);
select cooking_camel_schema.insert('Speedy Little Devils',
                                   '["Combine melted butter and dry cake mix.", "Reserve 1 1/4 cups of this for top crust.", "Pat remaining crumb mixture into ungreased 13 x 9 x 2-inch pan.", "Top that layer with combined peanut butter and marshmallow cream.", "Spread evenly.", "Crumble remaining cake mixture over that.", "Bake 20 minutes at 350\u00b0.", "Cool; cut into bars.", "Makes 3 dozen."]',
                                   '["1 devils food cake mix", "3/4 c. peanut butter", "1 stick oleo, melted", "1 (7 oz.) jar marshmallow cream"]',
                                   ARRAY ['cake mix', 'peanut butter', 'oleo', 'marshmallow cream']);
select cooking_camel_schema.insert('Martha Washington Candy',
                                   '["Mix together 1 box confectioners sugar, Eagle Brand milk and vanilla, then thicken with coconut and then add as many pecans as desired.", "Mix well.", "Put in freezer for 2 to 3 hours or until extremely stiff, then roll in balls, using the other box of confectioners sugar to roll in.", "Set aside.", "Melt 1/2 to 3/4 of a block of paraffin and 1 box of Bakers semi-sweet chocolate."]',
                                   '["2 boxes confectioners sugar", "1 can Eagle Brand milk", "1 tsp. vanilla", "7 oz. coconut (not frozen)", "pecans", "1 box Bakers semi-sweet chocolate", "paraffin"]',
                                   ARRAY ['confectioners sugar', 'milk', 'vanilla', 'coconut', 'pecans', 'chocolate', 'paraffin']);
select cooking_camel_schema.insert('24 Hour Salad',
                                   '["Layer vegetables in large bowl.", "Top with bacon bits.", "Mix mayonnaise and sugar together and pour on top of salad, making sure top is covered completely.", "Cover and place in refrigerator overnight.", "Put shredded cheese on top just before serving."]',
                                   '["1 head lettuce", "1 c. chopped onion", "1/2 c. bacon bits", "2 c. mayonnaise", "1 pkg. shredded Swiss cheese", "1 c. cauliflower (in pieces)", "1 c. chopped celery", "1 c. frozen peas", "3 Tbsp. sugar"]',
                                   ARRAY ['head lettuce', 'onion', 'bacon bits', 'mayonnaise', 'Swiss cheese', 'cauliflower', 'celery', 'frozen peas', 'sugar']);
select cooking_camel_schema.insert('Rocky Road Fudge',
                                   '["Grease 8 x 8 x 2-inch baking pan.", "In 2-quart saucepan, melt margarine over low heat.", "Stir in cocoa, corn syrup, water and vanilla until well blended.", "Remove from heat.", "Gradually stir in confectioners sugar until well blended and smooth.", "Stir in marshmallows and nuts.", "Turn into prepared pan.", "Cover and refrigerate until firm.", "Cut into squares.", "Makes about 1 3/4 pounds."]',
                                   '["1/2 c. margarine", "2/3 c. unsweetened cocoa", "1/2 c. light corn syrup", "1 Tbsp. water", "1 tsp. vanilla", "1 lb. confectioners sugar", "1 c. miniature marshmallows", "1/2 c. chopped nuts"]',
                                   ARRAY ['margarine', 'unsweetened cocoa', 'light corn syrup', 'water', 'vanilla', 'confectioners sugar', 'marshmallows', 'nuts']);
select cooking_camel_schema.insert('Ice Cream', '["Beat with electric mixer.", "Put in freezer."]',
                                   '["2 eggs", "2 c sugar", "1 can Eagle brand milk", "1/2 pt cream", "2 tsp vanilla", "pinch of salt", "2 qts milk"]',
                                   ARRAY ['eggs', 'sugar', 'milk', 'cream', 'vanilla', 'salt', 'milk']);
select cooking_camel_schema.insert('No Bake Persimmon Pudding',
                                   '["Mix pulp, sugar, peanuts and marshmallows.", "Add graham cracker crumbs.", "Shape into roll, adding more crumbs, if needed, to retain shape.", "Chill thoroughly.", "Serve with whipped cream."]',
                                   '["1 c. persimmon pulp", "1 c. powdered sugar", "2 c. graham cracker crumbs", "1/2 c. peanuts, chopped", "1/2 c. miniature marshmallows", "whipped cream"]',
                                   ARRAY ['persimmon pulp', 'powdered sugar', 'graham cracker crumbs', 'peanuts', 'marshmallows', 'whipped cream']);
select cooking_camel_schema.insert('Fruitcake Cookies',
                                   '["Cream butter and sugar.", "Add eggs.", "Add other ingredients and mix well.", "Drop by teaspoonfuls onto a cookie sheet.", "Bake at 300 for 20 to 30 minutes."]',
                                   '["1 c. light brown sugar", "3 eggs", "3 c. self rising flour", "1 tsp. cinnamon", "1/2 c. milk", "2 lbs candied fruit or 6 slices of candied pineapple and 2 cups of candied cherries", "3 to 4 c. of pecans"]',
                                   ARRAY ['light brown sugar', 'eggs', 'flour', 'cinnamon', 'milk', 'candied fruit', 'pecans']);
select cooking_camel_schema.insert('Chicken And Tortilla Casserole',
                                   '["Boil chicken; bone and cut up meat.", "To the meat, add onion and green pepper.", "Mix soups, tomatoes, chili powder and garlic salt.", "Dip each tortilla in chicken broth, then in a buttered 9 x 12-inch baking dish.", "Place a layer of tortilla, 1/2 the chicken, 1/2 the soup mixture and 1/2 cheese.", "Repeat layers; bake 30 to 40 minutes in 350\u00b0 oven until cheese melts."]',
                                   '["1 medium chicken", "1 can (12) soft tortillas", "1 large chopped onion", "1 large chopped green pepper", "1 can mushroom soup", "1 can cream of chicken soup", "1 can tomatoes and green chilies", "1/2 tsp. chili powder", "1/2 tsp. garlic salt", "1 lb. Cheddar cheese, grated"]',
                                   ARRAY ['chicken', 'tortillas', 'onion', 'green pepper', 'mushroom soup', 'cream of chicken soup', 'tomatoes', 'chili powder', 'garlic salt', 'Cheddar cheese']);
select cooking_camel_schema.insert('Fruit Pizza',
                                   '["Press out cookie dough flat on a 13-inch pizza pan or cookie sheet.", "Bake according to package directions.", "Cream together cream cheese and powdered sugar.", "Spread on cooled crust.", "Top with chopped or sliced fruits and sprinkle with coconut.", "Yields 1 pizza."]',
                                   '["1 tube refrigerator enriched sugar cookie dough", "8 oz. cream cheese, softened", "assorted canned or fresh fruits, sliced", "1/2 c. powdered sugar", "coconut"]',
                                   ARRAY ['cream cheese', 'fresh fruits', 'powdered sugar', 'coconut']);
select cooking_camel_schema.insert('Harvard Beets',
                                   '["Melt fat and stir in flour.", "Gradually add boiling water and cook until thickened, stirring constantly.", "Add vinegar, sugar and seasonings.", "Mix well until sugar dissolves.", "Add beets and cook until thoroughly heated.", "If canned beets are used, substitute 1/4 cup liquid from the can of beets for the water.", "Makes 6 servings."]',
                                   '["2 Tbsp. butter or margarine", "2 Tbsp. flour", "1/4 c. boiling water", "1/4 c. vinegar", "1/3 c. brown sugar", "1/2 tsp. salt", "1/8 tsp. pepper", "1/8 tsp. ground cloves", "2 1/2 c. diced, cooked beets"]',
                                   ARRAY ['butter', 'flour', 'boiling water', 'vinegar', 'brown sugar', 'salt', 'pepper', 'ground cloves']);
select cooking_camel_schema.insert('Clam Chowder',
                                   '["Dice bacon and onion. Saute in soup pot. Add remaining ingredients.", "Heat; do not boil.", "May be thickened, if necessary."]',
                                   '["6 to 8 lean slices diced bacon", "2 c. diced, cooked potatoes", "1 c. diced onion", "2 cans minced clams, drained (reserve 1 c. clam juice)", "2 c. half and half", "1 c. water", "2 Tbsp. butter", "salt and pepper to taste"]',
                                   ARRAY ['bacon', 'potatoes', 'onion', 'clams', 'water', 'butter', 'salt']);
select cooking_camel_schema.insert('Easy Cranberry Relish',
                                   '["In food processor, mix cranberries, sugar and whole orange (cutting it into 2 to 4 parts seems to work better).", "Mix ingredients in processor until chopped.", "Transfer mixture into a mixing bowl and add chopped walnuts.", "Chill and serve."]',
                                   '["2 small pkg. fresh cranberries", "1 c. sugar (or more if you like)", "1 whole orange", "walnuts"]',
                                   ARRAY ['fresh cranberries', 'sugar', 'orange', 'walnuts']);
select cooking_camel_schema.insert('Banana Omelette',
                                   '["Melt the butter in a skillet and saut the bananas about 5 minutes turning them frequently.", "Remove from the pan and set aside.", "Beat the egg yolks with the salt, cayenne pepper and milk. Beat the egg whites until stiff and fold the yolks and whites together.", "Transfer to a buttered 7 x 10 inch shallow casserole and arrange the banana slices on top.", "Bake in a 350 degree oven for 20 minutes or until lightly browned.", "Sprinkle with parsley and serve from the casserole."]',
                                   '["3 Tbsp. Butter", "4 Bananas (sliced)", "6 Eggs (separated)", "1/2 tsp. Salt", "Dash of Cayenne Pepper", "1/4 c. Milk", "2 Tbsp. Chopped Parsley"]',
                                   ARRAY ['Butter', 'Bananas', 'Eggs', 'Salt', 'Cayenne Pepper', 'Milk', 'Parsley']);
select cooking_camel_schema.insert('Taco Soup',
                                   '["Brown hamburger with onion. Drain.", "Add taco seasoning. Combine meat mixture with all remaining ingredients.", "Simmer 20 minutes.", "Serve with Cheddar cheese, sour cream, crushed corn chips and chopped avocado.", "Let each person create their own. Delicious and fun!"]',
                                   '["1 lb. hamburger", "1 onion, chopped", "1/2 pkg. dry taco seasoning", "1 can kidney beans", "1 can butter beans", "1 can tomatoes", "1 small can tomato sauce", "1 (12 oz.) can tomato juice or V-8 juice"]',
                                   ARRAY ['hamburger', 'onion', 'taco', 'kidney beans', 'butter beans', 'tomatoes', 'tomato sauce', 'tomato juice']);
select cooking_camel_schema.insert('Frosty Pudding Cones',
                                   '["In a mixing bowl, combine milk and lemon juice. Mix well.", "Add yogurt.", "Mix well.", "Spoon mixture into cones.", "Set upright in glasses or jars and place in freezer.", "Freeze 3 hours.", "Top each cone with 1 tablespoon whipped topping.", "Serves 6."]',
                                   '["2/3 c. sweetened condensed milk", "2 Tbsp. lemon juice", "6 sugar cones (the hard type)", "1/2 c. whipped cream or Cool Whip", "8 oz. fruit yogurt"]',
                                   ARRAY ['condensed milk', 'lemon juice', 'sugar', 'whipped cream', 'fruit yogurt']);
select cooking_camel_schema.insert('Easy Marinade',
                                   '["Mix all ingredients together and pour over chicken. Let set as little as 1 hour or overnight for really juicy chicken."]',
                                   '["1/2 c. soy sauce", "1/4 c. oil", "1/4 c. red wine vinegar", "1 tsp. oregano", "1 tsp. basil", "1 tsp. minced onion", "1/4 tsp. pepper"]',
                                   ARRAY ['soy sauce', 'oil', 'red wine vinegar', 'oregano', 'basil', 'onion', 'pepper']);
select cooking_camel_schema.insert('Pina Colada Muffins',
                                   '["Use electric mixer.", "Prepare cake as directed on box.", "Stir in remaining ingredients and mix 1 minute.", "Use muffin cups or grease muffin pans well.", "Preheat oven to 350\u00b0.", "Bake for 15 to 20 minutes.", "I frosted mine with cream cheese frosting."]',
                                   '["1 box Pillsbury yellow cake mix", "1 tsp. coconut flavoring", "1 tsp. rum flavoring", "1 c. coconut", "1/2 c. chopped nuts", "1 c. drained crushed pineapple"]',
                                   ARRAY ['yellow cake', 'coconut flavoring', 'rum flavoring', 'coconut', 'nuts', 'pineapple']);
select cooking_camel_schema.insert('Oriental Tossed Salad',
                                   '["Mix all together right before serving. Serves 12 to 15."]',
                                   '["3/4 c. sugar", "1/2 c. red wine vinegar", "1 c. oil", "3 Tbsp. soy sauce", "2 pkg. Ramen noodles, crushed", "1 c. chopped walnuts", "1 bunch chopped green onion", "1 bunch broccoli florets", "2 pkg. romaine lettuce"]',
                                   ARRAY ['sugar', 'red wine vinegar', 'oil', 'soy sauce', 'Ramen noodles', 'walnuts', 'green onion', 'broccoli florets', 'romaine lettuce']);
select cooking_camel_schema.insert('Applesauce Cake',
                                   '["Beat the sugars (white and brown) and oil together. Add eggs and beat again. Add applesauce, raisins, salt and soda, then flour. Stir in walnuts or pecans.", "Bake in large flat pan, 13 x 18-inches, at 350\u00b0."]',
                                   '["1/2 c. white sugar", "2 c. brown sugar", "1 stick margarine", "1/2 c. oil", "2 c. applesauce", "2 tsp. soda", "1/2 tsp. salt", "2 eggs", "1 c. ground raisins", "1/2 c. walnuts or pecans", "2 1/2 c. flour", "1 tsp. cinnamon", "1/4 tsp. cloves"]',
                                   ARRAY ['white sugar', 'brown sugar', 'margarine', 'oil', 'applesauce', 'soda', 'salt', 'eggs', 'ground raisins', 'walnuts', 'flour', 'cinnamon', 'cloves']);
select cooking_camel_schema.insert('Mayonnaise',
                                   '["Mix egg yolk slightly.", "Add oil, 1 drop at a time, until it begins to thicken, then add slowly and steadily.", "Add lemon juice and honey.", "Store in fridge."]',
                                   '["1 pt. oil", "juice of 1/2 lemon", "1 egg yolk", "1 tsp. honey"]',
                                   ARRAY ['oil', 'lemon', 'egg yolk', 'honey']);
select cooking_camel_schema.insert('ShepherdS Pie',
                                   '["Fry hamburg and onion until brown.", "Drain off liquid.", "Add salt and pepper.", "Spoon into 1-quart casserole and place potatoes on top.", "Put butter and paprika over potatoes.", "Bake in a 425\u00b0 oven for 15 minutes."]',
                                   '["1 lb. hamburg", "1/4 c. chopped onion", "1/4 tsp. salt", "1/8 tsp. pepper", "1 c. mashed potatoes"]',
                                   ARRAY ['hamburg', 'onion', 'salt', 'pepper', 'potatoes']);
select cooking_camel_schema.insert('Fresh Apple Cake',
                                   '["Mix all ingredients together.", "Bake in a greased and floured 13 x 9-inch pan.", "Bake at 350\u00b0 for 45 minutes.", "I use a tube pan."]',
                                   '["3 c. chopped, raw apple", "2 c. flour", "2 c. sugar", "1/2 c. shortening (I used 1 stick oleo)", "2 eggs", "1/2 tsp. salt", "1 tsp. baking soda", "2 tsp. vanilla", "1/2 tsp. nutmeg", "1/2 tsp. cinnamon", "1 c. chopped nuts"]',
                                   ARRAY ['apple', 'flour', 'sugar', 'shortening', 'eggs', 'salt', 'baking soda', 'vanilla', 'nutmeg', 'cinnamon', 'nuts']);
select cooking_camel_schema.insert('Brown Rice Pizza(Light)  ',
                                   '["Combine rice, 1/2 cup cheese and 1/2 teaspoon oregano in a medium bowl.", "Stir well.", "Press mixture evenly into a 12-inch pizza pan coated with Pam.", "Bake at 400\u00b0 for 25 minutes.", "Coat a large nonstick skillet with Pam.", "Place over medium-high heat until hot.", "Add broccoli, zucchini, mushrooms and onion.", "Saute until tender.", "Combine tomato sauce and remaining oregano.", "Spread evenly over baked crust.", "Top with sauteed vegetable mixture. Sprinkle with remaining 1 cup cheese.", "Bake at 400\u00b0 for 10 minutes or until pizza is thoroughly heated and cheese is melted.", "Yields 4 servings (255 calories each)."]',
                                   '["1 1/2 c. cooked brown rice (without salt or fat)", "1 1/2 c. (6 oz.) shredded part skim milk Mozzarella cheese, divided", "1 egg, beaten (I use Second Nature)", "1 tsp. oregano, divided", "Pam", "1 c. broccoli flowerets", "1 c. sliced zucchini", "1 c. sliced fresh mushrooms", "1 small onion, sliced", "8 oz. can tomato sauce (no salt)"]',
                                   ARRAY ['brown rice', 'Mozzarella cheese', 'egg', 'oregano', 'broccoli flowerets', 'zucchini', 'mushrooms', 'onion', 'tomato sauce']);
select cooking_camel_schema.insert('Creamy Shells With Broccoli And Ham',
                                   '["Cook shells according to package directions.", "Slice or cube ham; cut broccoli into 1/2-inch pieces.", "Saute garlic, ham and broccoli in margarine in a large skillet until broccoli is crisp and tender (approximately 5 minutes).", "Stir in cream.", "Cook over medium heat 3 minutes.", "Stir in cheese.", "Lower heat and cook, stirring often, until cheese is melted.", "Drain shells and toss with sauce.", "Serve."]',
                                   '["1 (1 lb.) box medium size macaroni shells", "1/2 lb. cooked ham", "1 (10 oz.) pkg. frozen broccoli, thawed", "1 clove garlic, crushed", "1/2 c. margarine", "1 c. heavy cream", "1 c. grated Parmesan cheese"]',
                                   ARRAY ['macaroni', 'ham', 'frozen broccoli', 'clove garlic', 'margarine', 'heavy cream', 'Parmesan cheese']);
select cooking_camel_schema.insert('Chicken Over Rice', '["Boil all ingredients until tender.", "Serve over rice."]',
                                   '["1 chopped onion", "2 chopped bell peppers", "1/2 bunch celery", "1 can chicken broth", "2 chopped potatoes", "little soy sauce and cornstarch"]',
                                   ARRAY ['onion', 'bell peppers', 'celery', 'chicken broth', 'potatoes', 'soy sauce']);
select cooking_camel_schema.insert('Meatball Chop Suey',
                                   '["Mix ground beef, bread crumbs, milk, 2 tablespoons onion, egg, salt and pepper.", "Shape into 24 meatballs and brown in lard or drippings.", "Pour off drippings.", "Dissolve bouillon cubes in hot water; add bouillon, remaining onion, soy sauce and celery to meatballs.", "Cover tightly and cook slowly for 15 minutes.", "Remove meatballs."]',
                                   '["2 lb. ground beef", "1/2 c. bread crumbs", "1 c. milk", "2/3 c. onion, chopped", "1 egg", "1 tsp. salt", "1/8 tsp. pepper", "3 Tbsp. lard or drippings", "2 beef bouillon cubes", "3 c. hot water", "1/4 c. soy sauce", "2 c. celery, cut in 1/2-inch strips", "3 Tbsp. cornstarch", "2 Tbsp. cold water", "2 c. bean sprouts, drained", "1 c. mushroom stems (4 oz.)", "cooked rice or chow mein noodles"]',
                                   ARRAY ['ground beef', 'bread crumbs', 'milk', 'onion', 'egg', 'salt', 'pepper', 'lard', 'water', 'soy sauce', 'celery', 'cornstarch', 'cold water', 'bean sprouts', 'mushroom stems', 'rice']);
select cooking_camel_schema.insert('Vegetable Beef Soup',
                                   '["Add beef, tomatoes, soup and onion in crock-pot.", "Add water, frozen vegetables, potatoes and celery.", "Add salt and pepper and other spices of preference.", "Stir well.", "Cook at lowest setting for 4 to 6 hours."]',
                                   '["1 lb. ground beef, cooked and drained", "1 large can tomatoes (whole)", "1 can tomato soup", "1 small onion, chopped", "2 c. water", "1 pkg. frozen mixed vegetables", "1 c. potatoes, cut up and cooked until tender", "1 c. diced celery", "1/4 tsp. salt", "1/4 tsp. pepper"]',
                                   ARRAY ['ground beef', 'tomatoes', 'tomato soup', 'onion', 'water', 'mixed vegetables', 'potatoes', 'celery', 'salt', 'pepper']);
select cooking_camel_schema.insert('Hawaiian Marshmallow Pie',
                                   '["Microwave marshmallows and reserved 1/2 cup pineapple liquid in large microwave safe bowl on High 2 to 2 1/2 minutes, or until smooth when stirred, stirring halfway through heating time. Refrigerate 30 minutes or until slightly thickened; mix until well blended.", "Fold in pineapple and whipped topping.", "Pour into crust. Refrigerate several hours or overnight.", "Garnish with pineapple chunks and maraschino cherries.", "Makes 6 servings."]',
                                   '["24 Kraft jet-puffed marshmallows or 3 c. Kraft miniature marshmallows", "2 cans (8 oz. each) crushed pineapple, drained, reserving 1/2 c. liquid", "2 c. thawed Cool Whip nondairy whipped topping", "1 prepared graham cracker crumb crust (6 oz.)"]',
                                   ARRAY ['marshmallows', 'pineapple', 'graham cracker crumb crust']);
select cooking_camel_schema.insert('Sugar-Free Sweet-N-Sour Stir-Fry',
                                   '["Cook vegetables 2 minutes and add water chestnuts and green pepper.", "Cook until crisp and add Sweet-N-Sour Sauce."]',
                                   '["1 tsp. vegetable oil", "2 stalks celery, sliced diagonally", "1 head cabbage, shredded", "1/2 c. water chestnuts", "1 recipe Sweet-N-Sour Sauce", "3 carrots, sliced diagonally", "1 chopped onion", "2 zucchini, sliced", "1/4 c. green pepper, chopped"]',
                                   ARRAY ['vegetable oil', 'stalks celery', 'cabbage', 'water chestnuts', 'N', 'carrots', 'onion', 'zucchini', 'green pepper']);
select cooking_camel_schema.insert('Graham Cracker Bars',
                                   '["Preheat oven to 350\u00b0.", "Grease pan.", "Divide graham crackers into smallest part and put into bottom of pan.", "Melt together the butter and margarine.", "Add 1/2 c sugar boil for 2 minutes.", "Remove from heat add pecans (as many as desired).", "Mix and pour over graham crackers.", "Bake for 6 minutes on the bottom rack."]',
                                   '["Graham crackers", "1 stick of margarine", "1 stick of butter", "1/2 c sugar", "pecans"]',
                                   ARRAY ['crackers', 'margarine', 'butter', 'sugar', 'pecans']);
select cooking_camel_schema.insert('Red Cabbage',
                                   '["Saute the onion in the bacon drippings or olive oil until tender.", "Add the cabbage and saute 10 minutes.", "Add the apples, wine vinegar, sugar and salt.", "Simmer, covered, 2 hours.", "Stir and check for burning.", "Add the jelly and simmer 1/2 hour more."]',
                                   '["3 Tbsp. bacon drippings or olive oil", "1 onion, chopped", "1 large red cabbage, shredded", "2 cooking apples, chopped", "1/2 c. wine vinegar", "1 Tbsp. sugar", "1 tsp. salt", "1/2 jar currant jelly"]',
                                   ARRAY ['bacon', 'onion', 'red cabbage', 'cooking apples', 'wine vinegar', 'sugar', 'salt', 'currant jelly']);
select cooking_camel_schema.insert('Ambrosia Salad',
                                   '["Drain pineapple, oranges and cherries, put in bowl and mix all ingredients together.", "Put in refrigerator."]',
                                   '["1 can chunk pineapple", "1 can mandarin oranges", "1 small jar maraschino cherries", "1 container sour cream", "1 small pkg. miniature marshmallows", "1 can flaked coconut"]',
                                   ARRAY ['pineapple', 'mandarin oranges', 'maraschino cherries', 'sour cream', 'marshmallows', 'flaked coconut']);
select cooking_camel_schema.insert('Sour Cream Pound Cake',
                                   '["Mix sugar, margarine and Crisco.", "Add eggs, one at a time. Beat on low.", "Add flour, sour cream and vanilla.", "Bake at 325\u00b0 for about 1 hour and 15 minutes."]',
                                   '["3 c. sugar", "2 sticks margarine", "1/4 c. Crisco", "6 eggs", "3 c. sifted cake flour", "8 oz. sour cream", "1 tsp. vanilla flavoring"]',
                                   ARRAY ['sugar', 'margarine', 'Crisco', 'eggs', 'cake flour', 'sour cream', 'vanilla flavoring']);
select cooking_camel_schema.insert('Soft Delicious Pumpkin Bars', '["Bake at 350\u00b0 for 25 to 30 minutes."]',
                                   '["2 c. flour", "2 tsp. baking powder", "1/2 tsp. salt", "2 tsp. cinnamon", "4 eggs", "1 c. nuts", "2 c. pumpkin", "1 tsp. soda", "2 c. sugar", "1 c. oil"]',
                                   ARRAY ['flour', 'baking powder', 'salt', 'cinnamon', 'eggs', 'nuts', 'pumpkin', 'soda', 'sugar', 'oil']);
select cooking_camel_schema.insert('Barbecue Sauce',
                                   '["Combine tomato sauce, brown sugar, vinegar, onion, salt, pepper and garlic powder.", "Simmer on medium heat 5 to 8 minutes."]',
                                   '["1 can tomato sauce", "1/4 c. brown sugar", "1/4 c. vinegar", "1/2 c. minced onion", "salt and pepper to taste", "1 tsp. garlic powder"]',
                                   ARRAY ['tomato sauce', 'brown sugar', 'vinegar', 'onion', 'salt', 'garlic powder']);
select cooking_camel_schema.insert('Sausage Strata',
                                   '["Arrange bread in bottom of greased baking dish (10 x 6-inch). Brown sausage and drain off fat.", "Spoon sausage evenly over bread. Sprinkle with cheese.", "Combine remaining ingredients and pour over all.", "Bake at 350\u00b0 for 25 to 30 minutes.", "Can be made ahead and refrigerated until needed.", "If so, bake for 30 to 35 minutes."]',
                                   '["6 slices bread (crusts removed)", "1 1/2 lb. sausage", "1 c. Swiss cheese, grated", "4 eggs, slightly beaten", "1 1/2 c. milk", "3/4 c. light cream", "1/2 tsp. salt", "dash of pepper", "dash of nutmeg", "1 tsp. Worcestershire sauce"]',
                                   ARRAY ['bread', 'sausage', 'Swiss cheese', 'eggs', 'milk', 'light cream', 'salt', 'pepper', 'nutmeg', 'Worcestershire sauce']);
select cooking_camel_schema.insert('Pepperoni Spaghetti',
                                   '["Combine onion, green pepper, ground beef and pepperoni in a large skillet.", "Cook over medium heat until beef browns, stirring to crumble.", "Add spaghetti sauce and bring to a boil.", "Cover, reduce heat and simmer 20 minutes, stirring occasionally."]',
                                   '["1 large onion, chopped", "1 green pepper, chopped", "1 lb. ground beef", "1 (3 oz.) pkg. sliced pepperoni, chopped", "1 (32 oz.) jar spaghetti sauce with mushrooms", "1 (12 oz.) pkg. spaghetti", "1 c. (4 oz.) shredded Mozzarella cheese", "1 Tbsp. grated Parmesan cheese"]',
                                   ARRAY ['onion', 'green pepper', 'ground beef', 'pepperoni', 'mushrooms', 'spaghetti', 'Mozzarella cheese', 'Parmesan cheese']);
select cooking_camel_schema.insert('Florida Punch',
                                   '["Bring to a boil the sugar and water until sugar is dissolved. Add cranberry, pineapple and orange juices.", "When ready to serve, add ginger ale."]',
                                   '["1 c. sugar", "2 c. water", "4 c. cranberry juice", "4 c. pineapple juice", "2 c. orange juice", "1 qt. ginger ale"]',
                                   ARRAY ['sugar', 'water', 'cranberry juice', 'pineapple juice', 'orange juice', 'ginger ale']);
select cooking_camel_schema.insert('"Peachy" Cake',
                                   '["Beat eggs.", "Then add flour, oil, vanilla, sugar, baking powder and juice.", "Beat at medium speed until creamy.", "Grease and flour or spray with \"Pam\" a 10-inch tubular pan.", "Pour 1/2 batter; line with sliced peaches (drained), 1/2 can.", "Sprinkle sugar and cinnamon.", "Pour remaining batter.", "Line with remaining sliced peaches; sprinkle with sugar and cinnamon.", "Bake at 350\u00b0 for 1 to 1 1/2 hours, until \"tester\" comes out of cake dry.", "(I use a long knife.) Enjoy!"]',
                                   '["3 c. flour", "1 c. oil", "4 eggs", "3 tsp. vanilla", "2 c. sugar", "3 tsp. baking powder", "1/2 c. peach juice from can", "1 (20 or 29 oz.) can sliced peaches"]',
                                   ARRAY ['flour', 'oil', 'eggs', 'vanilla', 'sugar', 'baking powder', 'peach juice from', 'peaches']);
select cooking_camel_schema.insert('Fruity Ice', '["Mix ingredients in blender, adding ice slowly."]',
                                   '["2 peeled oranges", "2 peeled bananas", "2 c. crushed ice", "2 c. applesauce, unsweetened", "1/2 tsp. cinnamon"]',
                                   ARRAY ['oranges', 'bananas', 'crushed ice', 'applesauce', 'cinnamon']);
select cooking_camel_schema.insert('Five Way Chili',
                                   '["Lightly brown beef. Add water and mix. Add all other ingredients. Simmer, uncovered, 3 hours. Stir occasionally or cook in crock-pot."]',
                                   '["2 lb. ground beef", "3 c. water", "1 (15 oz.) can tomato sauce", "2 bay leaves", "1/2 tsp. salt", "2 tsp. ground cumin", "1 tsp. ground cinnamon", "1 tsp. Worcestershire sauce", "1 1/2 tsp. vinegar", "1 1/2 tsp. ground allspice", "2 Tbsp. chili powder"]',
                                   ARRAY ['ground beef', 'water', 'tomato sauce', 'bay leaves', 'salt', 'ground cumin', 'ground cinnamon', 'Worcestershire sauce', 'vinegar', 'ground allspice', 'chili powder']);
select cooking_camel_schema.insert('Hot Tomatoes And Cucumbers',
                                   '["Cook and stir cucumbers and onion in butter or margarine in a skillet for about 5 minutes. Stir in tomatoes.", "Sprinkle with salt and pepper. Cook until tomatoes are just heated through. Sprinkle with dill and serve hot."]',
                                   '["2 medium cucumbers, cut into 1-inch pieces", "1 medium onion, sliced and separated into rings", "2 Tbsp. butter or margarine", "4 medium tomatoes, cut in wedges", "1/2 tsp. salt", "dash of pepper", "1 Tbsp. fresh dill or 1 tsp. dried dill"]',
                                   ARRAY ['cucumbers', 'onion', 'butter', 'tomatoes', 'salt', 'pepper', 'fresh dill']);
select cooking_camel_schema.insert('Fluffy White Icing',
                                   '["Mix all ingredients together, except milk.", "Beat at high speed; slowly add milk."]',
                                   '["2 c. 10x sugar", "2 Tbsp. flour", "1 egg white", "1/2 c. Crisco", "1 Tbsp. butter", "1 tsp. vanilla", "2 Tbsp. milk"]',
                                   ARRAY ['sugar', 'flour', 'egg', 'Crisco', 'butter', 'vanilla', 'milk']);
select cooking_camel_schema.insert('Dishpan Cookies',
                                   '["Cream together the sugars, oil and eggs.", "Add baking powder, salt, flour and oats; mix well.", "Then add coconut, corn flakes, chocolate chips and nuts (optional).", "Mix well.", "Drop on cookie sheet.", "Bake 10 to 12 minutes at 325\u00b0.", "This takes a very large bowl to mix in."]',
                                   '["2 c. brown sugar", "2 c. granulated sugar", "2 c. oil", "4 eggs", "1/4 tsp. baking powder", "1 tsp. salt", "4 c. flour", "1 1/2 c. quick cooking oats", "2 c. coconut", "4 c. corn flakes, not crushed", "6 oz. chocolate chips", "1 c. nuts (optional)"]',
                                   ARRAY ['brown sugar', 'sugar', 'oil', 'eggs', 'baking powder', 'salt', 'flour', 'cooking oats', 'coconut', 'corn flakes', 'chocolate chips', 'nuts']);
select cooking_camel_schema.insert('Toll House Pie',
                                   '["Preheat oven to 325\u00b0.", "In large bowl, beat eggs until foamy. Add flour, sugar and brown sugar.", "Beat until well blended.", "Blend in melted butter.", "Stir in chocolate chips and walnuts.", "Pour into pie shell.", "Bake for 1 hour.", "Serve warm with whipped cream or ice cream."]',
                                   '["2 eggs", "1/2 c. all-purpose flour", "1/2 c. sugar", "1/2 c. packed brown sugar", "1 c. butter, melted and cooled", "6 oz. chocolate chips", "1 c. chopped walnuts", "1 (9-inch) unbaked pie shell", "whipped cream or ice cream"]',
                                   ARRAY ['eggs', 'all-purpose', 'sugar', 'brown sugar', 'butter', 'chocolate chips', 'walnuts', 'shell', 'whipped cream']);
select cooking_camel_schema.insert('Crunchy  Onion Burger',
                                   '["Mix beef, 2/3 cup French fried onions and seasonings; shape into 6 burgers.", "Grill or broil 10 minutes or until no longer pink in center, turning twice.", "Serve on rolls and top with 2/3 cup onions.", "Makes 6 servings."]',
                                   '["1 1/2 lb. ground beef", "1 1/3 c. (2.8 oz. can) French fried onions or fried onion rings", "3/4 tsp. salt", "1/4 tsp. salt", "6 rolls"]',
                                   ARRAY ['ground beef', 'onions', 'salt', 'salt', 'rolls']);
select cooking_camel_schema.insert('Pumpkin Squares',
                                   '["Combine flour, oats, 1/2 cup brown sugar and 1/2 cup butter in bowl.", "Mix until crumbly.", "Press into greased 13 x 9-inch pan. Bake at 350\u00b0 for 15 minutes.", "Combine pumpkin, evaporated milk, eggs, sugar and spices in mixing bowl.", "Beat well.", "Pour into crust.", "Bake at 350\u00b0 for 20 minutes.", "Combine nuts, brown sugar and butter.", "Sprinkle on top.", "Bake for 15 to 20 minutes until filling is set."]',
                                   '["1 c. flour", "1/2 c. quick oats", "1/2 c. brown sugar", "1/2 c. margarine", "1 (1 lb.) can pumpkin", "1 (13 1/2 oz.) evaporated milk", "2 eggs", "3/4 c. sugar", "1 tsp. cinnamon", "1/2 tsp. ginger", "1/4 tsp. cloves", "1/2 c. walnuts", "1/2 c. brown sugar", "2 Tbsp. butter"]',
                                   ARRAY ['flour', 'oats', 'brown sugar', 'margarine', 'pumpkin', 'milk', 'eggs', 'sugar', 'cinnamon', 'ginger', 'cloves', 'walnuts', 'brown sugar', 'butter']);
select cooking_camel_schema.insert('Old Time Buttermilk Pie',
                                   '["Soften butter and add sugar; cream together. Add flour and eggs; beat well. Stir in buttermilk, vanilla, and nutmeg. Pour into unbaked pie shell. Bake for 45 to 50 minutes at 350\u00b0. Place on wire rack to cool before serving."]',
                                   '["9 inch unbaked pie shell", "1/2 c. butter", "2 c. sugar", "3 tsp. flour, rounded", "3 eggs", "1 c. buttermilk", "1 tsp. vanilla", "dash of nutmeg (optional)"]',
                                   ARRAY ['shell', 'butter', 'sugar', 'flour', 'eggs', 'buttermilk', 'vanilla', 'nutmeg']);
select cooking_camel_schema.insert('Two Sweet Potato Pies',
                                   '["Boil sweet potatoes; peel and mash.", "Beat eggs and combine with potatoes, sugar and vanilla.", "Stir all together and pour into pastry shell.", "Bake at 350\u00b0 for 30 minutes.", "Let set 15 minutes before serving."]',
                                   '["4 large potatoes", "3 eggs", "1 c. sugar", "1 tsp. vanilla", "3/4 c. milk", "grated coconut (optional)", "1 (9-inch) pastry shell"]',
                                   ARRAY ['potatoes', 'eggs', 'sugar', 'vanilla', 'milk', 'coconut', 'pastry shell']);
select cooking_camel_schema.insert('Broccoli-Cauliflower Soup',
                                   '["Cut vegetables into small pieces, discarding any of the stem too tough to poke with a fingernail. Barely cover with broth and slowly cook until tender. In another pan, saut onion in butter or margarine on medium heat.", "Add flour to make a roux; slowly add flour, stirring constantly to thicken and prevent lumping. Slowly add milk while stirring constantly. Lower heat and cook 45 minutes; continue stirring occasionally. Serve with grated cheese and pepper."]',
                                   '["1 lb. broccoli", "1 lb. cauliflower", "chicken broth, water or bouillon", "1/2 c. butter", "1 small onion, diced", "1/2 c. flour", "1 qt. milk", "1 c. grated sharp Cheddar cheese", "black pepper"]',
                                   ARRAY ['broccoli', 'cauliflower', 'chicken broth', 'butter', 'onion', 'flour', 'milk', 'Cheddar cheese', 'black pepper']);
select cooking_camel_schema.insert('Fresh Apple Cake',
                                   '["Mix.", "Bake", "in\tthree", "9-inch pans at 325\u00b0 for 25 to 30 minutes or until done."]',
                                   '["1 1/2 c. Wesson oil", "2 c. sugar", "2 eggs, beaten", "3 c. peeled, chopped fresh apples", "3 c. sifted cake flour", "1 tsp. salt", "1 tsp. soda", "2 tsp. vanilla"]',
                                   ARRAY ['Wesson oil', 'sugar', 'eggs', 'fresh apples', 'cake flour', 'salt', 'soda', 'vanilla']);
select cooking_camel_schema.insert('Russian Tea',
                                   '["Mix all ingredients.", "Use 1 tablespoon (heaping) per cup of water."]',
                                   '["1 c. Tang", "1 c. sugar", "1/2 c. instant tea with lemon", "1/2 tsp. cloves", "1/2 tsp. cinnamon"]',
                                   ARRAY ['sugar', 'lemon', 'cloves', 'cinnamon']);
select cooking_camel_schema.insert('HunterS Delight',
                                   '["Melt butter in skillet.", "Add onion and cook 5 minutes.", "Add meat and seasonings.", "Cook until browned.", "Add corn and milk.", "Put potatoes in a 2-quart casserole; cover with meat mixture.", "Bake, uncovered, in a 375\u00b0 oven for about 1 1/2 hours.", "Yield:", "6 servings."]',
                                   '["1 Tbsp. butter", "1 Tbsp. onion", "1 1/2 lb. ground beef", "2 tsp. salt", "1/4 tsp. pepper", "1 (20 oz.) can cream-style corn", "1/2 c. milk", "1 qt. sliced pared potatoes"]',
                                   ARRAY ['butter', 'onion', 'ground beef', 'salt', 'pepper', 'cream-style', 'milk', 'potatoes']);
select cooking_camel_schema.insert('Pie Crust("Never Fail")  ',
                                   '["Cut shortening into flour and salt.", "Combine egg, water and vinegar.", "Pour liquid into flour mixture all at once.", "Blend with spoon, just until flour mixture is all moistened.", "This is an easy crust to handle and can be re-rolled without toughening.", "Bake at 450\u00b0 for 10 minutes."]',
                                   '["3 c. flour", "1 1/4 c. shortening", "1 tsp. salt", "1 egg, well beaten", "5 Tbsp. water", "1 Tbsp. vinegar"]',
                                   ARRAY ['flour', 'shortening', 'salt', 'egg', 'water', 'vinegar']);
select cooking_camel_schema.insert('Burnt Caramel Cake Icing',
                                   '["Put 2 cups sugar and milk in a saucepan.", "Add syrup.", "Put the 1/2 cup sugar in a small skillet and pour enough water over it to moisten good.", "Turn on low heat under saucepan.", "While it is heating, brown the sugar in the skillet.", "When brown, pour it into the saucepan.", "Cook until soft ball forms in cold water.", "Remove from stove and beat until ready to spread on the cake.", "Add butter, the size of a walnut, and flavoring."]',
                                   '["2 c. sugar", "3/4 c. milk", "1 Tbsp. white Karo syrup", "1/2 c. sugar"]',
                                   ARRAY ['sugar', 'milk', 'white Karo syrup', 'sugar']);
select cooking_camel_schema.insert('Chicken Sweet-Sour',
                                   '["Mix ingredients; pour over chicken.", "Bake for 1 1/2 hours at 350\u00b0."]',
                                   '["cut up chicken", "1 jar apricot preserves", "1 bottle Catalina salad dressing", "1 envelope Lipton onion soup (dry)"]',
                                   ARRAY ['chicken', 'apricot preserves', 'salad dressing', 'onion soup']);
select cooking_camel_schema.insert('Microwave Fudge',
                                   '["Stir and microwave first 3 ingredients for 3 minutes.", "Stir in vanilla and nuts.", "Put into pan."]',
                                   '["2 c. semi-sweet chocolate chips", "1 c. sweet chocolate chips", "1 can sweetened condensed milk", "1 1/2 tsp. vanilla", "nuts (optional)"]',
                                   ARRAY ['semi-sweet chocolate chips', 'sweet chocolate chips', 'condensed milk', 'vanilla', 'nuts']);
select cooking_camel_schema.insert('Breakfast Rolls',
                                   '["Place nuts in bottom of greased Bundt pan.", "Arrange rolls on top.", "Sprinkle dry pudding over rolls.", "Cook butter, sugar and cinnamon over low heat until sugar is dissolved and mixture bubbles; pour over rolls.", "Cover tightly with foil and let stand on counter overnight.", "Next morning, bake at 350\u00b0 for 30 minutes (take foil off before baking).", "Let stand 5 minutes, then invert onto serving dish."]',
                                   '["1 bag frozen dinner rolls", "1 (3 5/8 oz.) pkg. butterscotch pudding (not instant)", "1/2 c. butter", "3/4 tsp. cinnamon", "3/4 c. brown sugar", "1/2 c. chopped nuts"]',
                                   ARRAY ['dinner rolls', 'butterscotch pudding', 'butter', 'cinnamon', 'brown sugar', 'nuts']);
select cooking_camel_schema.insert('Kentucky Cream Candy',
                                   '["Put cream cheese in mixer bowl 30 minutes to soften.", "Add salt and vanilla.", "Add 2 cups sugar; beat.", "Add 2 more cups of sugar; beat.", "Add remaining sugar and beat well.", "Cover and chill in refrigerator until firm.", "Shape into small balls and roll in coconut.", "Store in a foil-lined metal box in refrigerator."]',
                                   '["1 (8 oz.) pkg. cream cheese", "1/4 tsp. salt", "1 tsp. vanilla", "6 c. confectioners sugar", "finely chopped coconut"]',
                                   ARRAY ['cream cheese', 'salt', 'vanilla', 'confectioners sugar', 'coconut']);
select cooking_camel_schema.insert('Thousand Island Dressing',
                                   '["Mix all ingredients together.", "Makes 1 1/2 quarts."]',
                                   '["4 c. Miracle Whip", "1 can tomato soup", "1 Tbsp. vinegar", "4 Tbsp. sweet relish", "2 Tbsp. chili sauce", "1 Tbsp. sugar", "1 Tbsp. dry mustard", "1 small grated onion", "1 clove grated garlic"]',
                                   ARRAY ['Miracle', 'tomato soup', 'vinegar', 'sweet relish', 'chili sauce', 'sugar', 'mustard', 'onion', 'garlic']);
select cooking_camel_schema.insert('Rolls',
                                   '["Scald milk with butter.", "Pour into large mixing bowl.", "Add sugar and salt.", "Let cool.", "Add eggs (unbeaten), yeast cake and 1 1/2 cups flour.", "Mix well for two minutes.", "Stir remaining flour. Put in icebox and let rise overnight.", "Make rolls at least two hours before cooking."]',
                                   '["1 c. milk", "1 stick butter", "1 yeast cake, dissolved in 1/4 c. warm water", "1/3 c. sugar", "1 tsp. salt", "2 eggs", "4 1/2 c. sifted flour"]',
                                   ARRAY ['milk', 'butter', 'yeast', 'sugar', 'salt', 'eggs', 'flour']);
select cooking_camel_schema.insert('Brownies',
                                   '["Mix all ingredients together; add nuts.", "Pour into a greased and floured cookie sheet.", "Bake only 23 minutes in a 350\u00b0 oven. Cool and frost."]',
                                   '["1 1/2 c. white sugar", "1 1/2 c. brown sugar", "4 Tbsp. cocoa", "2 c. flour", "6 eggs", "1 1/2 sticks oleo, melted", "1/2 c. milk", "1 tsp. vanilla", "1/4 tsp. salt", "1/2 c. nuts"]',
                                   ARRAY ['white sugar', 'brown sugar', 'cocoa', 'flour', 'eggs', 'oleo', 'milk', 'vanilla', 'salt', 'nuts']);
select cooking_camel_schema.insert('Diabetic Cookies',
                                   '["Mix applesauce, margarine, eggs, vanilla and sugar.", "Add the remaining ingredients.", "Drop by teaspoon on cookie sheet and bake 15 minutes at 375\u00b0."]',
                                   '["1 1/2 c. unsweetened applesauce", "3/4 c. margarine", "1 Tbsp. vanilla", "2 c. oatmeal", "1/2 tsp. allspice", "1 1/2 tsp. soda", "1 c. raisins", "2 eggs", "1/3 c. brown Sugar Twin", "1 Tbsp. cinnamon", "1 1/2 c. flour", "1/2 tsp. salt", "1/4 c. nuts"]',
                                   ARRAY ['unsweetened applesauce', 'margarine', 'vanilla', 'oatmeal', 'allspice', 'soda', 'raisins', 'eggs', 'brown Sugar', 'cinnamon', 'flour', 'salt', 'nuts']);
select cooking_camel_schema.insert('Chocolate-Dipped Strawberries',
                                   '["Combine chocolate and whipping cream in a glass measuring cup or bowl. Microwave at Medium power for 1 minute or until the chocolate melts, stirring after 30 seconds. Stir in the almond extract and cool slightly. Dip each strawberry into the melted chocolate, allowing the excess to drip off. Place on waxed paper-lined baking sheet. Refrigerate or freeze for approximately 15 minutes, until the chocolate is set."]',
                                   '["2 (1 oz.) sq. semi-sweet chocolate, chopped", "1/2 Tbsp. whipping cream", "dash of almond extract", "8 strawberries"]',
                                   ARRAY ['semi-sweet chocolate', 'whipping cream', 'almond', 'strawberries']);
select cooking_camel_schema.insert('Working MotherS "Mess"(Renamed DadS Quick Delight)  ',
                                   '["Brown meat over medium heat in a large skillet.", "Remove meat from pan and drain off fat.", "Stir 1 to 3 tablespoons tamari sauce into meat.", "Saute onion, garlic and tomatoes.", "Add spaghetti sauce and heat.", "Add cooked beans and meat mixture.", "Stir gently to mix; then simmer to blend flavors.", "Serve when blended and heated through.", "Serves 4. Serve with garlic bread and green salad."]',
                                   '["1 lb. ground beef", "1 c. chopped onions", "2 to 3 cut-up tomatoes", "1 to 3 garlic buds (adjust for size and taste)", "16 oz. chunky spaghetti sauce", "1 to 3 Tbsp. tamari sauce (use smaller amount for low sodium diet)", "1 (16 oz.) can cooked beans (navy, pinto, kidney or pork and beans)"]',
                                   ARRAY ['ground beef', 'onions', 'tomatoes', 'garlic', 'chunky spaghetti sauce', 'tamari sauce', 'beans']);
select cooking_camel_schema.insert('Chicken With Tarragon',
                                   '["Lightly brown meat side of chicken breasts.", "Lay all 4 chicken breasts, meat side down, in small (8-inch) skillet.", "Add enough water, with chicken bouillon, added to just cover chicken.", "Add onion over top of chicken.", "Sprinkle with tarragon.", "Bring to boil and reduce heat to medium.", "Cover skillet with well-fitting lid and cook approximately 30 to 45 minutes or until chicken is done. Add a little water if necessary to replace any lost in steam."]',
                                   '["4 chicken breasts, skin removed", "1/2 c. onion, chopped fine", "1/2 tsp. tarragon", "chicken bouillon"]',
                                   ARRAY ['chicken breasts', 'onion', 'tarragon', 'chicken bouillon']);
select cooking_camel_schema.insert('Lemon Jello Vegetable Salad',
                                   '["Mix box of jello with the cup of boiling water.", "Mix until dissolved.", "Add cold water.", "Let jell slightly, then add all other ingredients.", "Mix and jell in a flat, 1 1/2-quart dish.", "Cut into squares to serve on a lettuce leaf."]',
                                   '["1 box lemon jello", "1 c. hot water", "3/4 c. cold water", "1/2 c. grated cabbage", "1/2 c. small chopped celery", "1/4 c. grated carrot", "1/8 c. finely chopped green pepper", "1/2 c. pineapple tidbits"]',
                                   ARRAY ['lemon jello', 'water', 'cold water', 'cabbage', 'celery', 'grated carrot', 'green pepper', 'pineapple tidbits']);
select cooking_camel_schema.insert('Shrimp Batter', '["Mix all ingredients with a mixer.", "Deep-fry shrimp."]',
                                   '["1 c. flour", "1/2 tsp. cornstarch", "1/2 tsp. soda", "1/2 tsp. baking powder", "1 beaten egg", "1/2 to 1 c. cold water", "paprika"]',
                                   ARRAY ['flour', 'cornstarch', 'soda', 'baking powder', 'egg', 'cold water', 'paprika']);
select cooking_camel_schema.insert('Chicken-Cheese Ball',
                                   '["Combine all ingredients, except nuts and cherry.", "Form into ball.", "Roll in enough nuts to cover.", "(If too soft, chill a little first, then roll in nuts.)", "Can garnish with cherry on top."]',
                                   '["1 small can chicken (all white meat)", "8 oz. cream cheese, softened", "1 Tbsp. minced onion", "2 Tbsp. soy sauce or lemon soy sauce", "1 Tbsp. mayonnaise", "chopped pecans", "maraschino cherry for garnish (if desired)"]',
                                   ARRAY ['chicken', 'cream cheese', 'onion', 'soy sauce', 'mayonnaise', 'pecans', 'maraschino cherry']);
select cooking_camel_schema.insert('Salted Nut Squares',
                                   '["Place half the peanuts in an ungreased 11 x 7-inch pan.", "In saucepan, melt butter and peanut butter chips over low heat.", "Add milk and marshmallows.", "Cook and stir until melted.", "Pour over peanuts.", "Sprinkle remaining peanuts on top.", "Cover; refrigerate. Cut into bars.", "Makes 5 to 6 dozen."]',
                                   '["3 c. salted peanuts without skins", "3 Tbsp. butter or margarine", "2 c. (12 oz.) peanut butter chips", "1 can sweetened condensed milk", "2 c. miniature marshmallows"]',
                                   ARRAY ['peanuts', 'butter', 'peanut butter', 'condensed milk', 'marshmallows']);
select cooking_camel_schema.insert('Date Cake',
                                   '["Sprinkle dates with baking soda and cover with hot water.", "Let stand until cool.", "Cream margarine, sugar and egg.", "Add dry ingredients, nuts and dates.", "Pour into lightly greased 8 x 8-inch pan and bake at 350\u00b0 for at least 45 minutes."]',
                                   '["1 pkg. dates, cut fine", "1 tsp. baking soda", "1 c. hot water", "1/2 c. margarine", "1 c. sugar", "1/2 tsp. salt", "1/2 c. walnuts", "1 egg", "1 1/2 c. flour"]',
                                   ARRAY ['dates', 'baking soda', 'water', 'margarine', 'sugar', 'salt', 'walnuts', 'egg', 'flour']);
select cooking_camel_schema.insert('Crescent Cake',
                                   '["Mix yellow cake mix, margarine, egg and 1/2 cup chopped nuts. This mixture will be thick.", "Press into greased 9 x 10-inch pan. Mix confectioners sugar, cream cheese and 2 eggs.", "Beat until smooth.", "Pour over cake batter.", "Bake at 350\u00b0 for 45 minutes."]',
                                   '["1 pkg. yellow cake mix", "1 stick margarine", "1 egg, beaten", "1/2 c. chopped nuts", "1 box confectioners sugar", "8 oz. cream cheese", "2 eggs, beaten"]',
                                   ARRAY ['yellow cake mix', 'margarine', 'egg', 'nuts', 'confectioners sugar', 'cream cheese', 'eggs']);
select cooking_camel_schema.insert('Freezer Pie Crust',
                                   '["Combine water and white syrup in a very large bowl.", "Add all other ingredients and mix well.", "Roll into crust size balls, wrap and freeze.", "Rolls out great.", "Makes 20 to 24 balls."]',
                                   '["3 lb. shortening", "5 lb. flour", "2 Tbsp. salt", "3 c. water", "1 c. white syrup"]',
                                   ARRAY ['shortening', 'flour', 'salt', 'water', 'white syrup']);
select cooking_camel_schema.insert('Basic Graham Cracker Crust',
                                   '["Preheat the oven to 375\u00b0. In the bowl of a food processor fitted with the metal blade, process the graham crackers and sugar to fine crumbs. With the motor running, add the butter and process until the crumbs are moist and stick together. Press the graham cracker mixture into the bottom and sides of a 9-inch pie pan. Bake in the center of the oven for 8 minutes or until the edges are slightly brown. Makes a single 9-inch crust."]',
                                   '["1 1/3 c. graham cracker crumbs (about 16 whole crackers)", "1/4 c. sugar", "5 Tbsp. unsalted butter, melted"]',
                                   ARRAY ['graham cracker crumbs', 'sugar', 'unsalted butter']);
select cooking_camel_schema.insert('Creamy Chicken And Mushrooms',
                                   '["In skillet, in 1 tablespoon hot margarine, cook chicken 10 minutes or until browned on both sides.", "Remove.", "In remaining 1 tablespoon hot margarine, cook mushrooms and onion with garlic powder until tender and liquid is evaporated (stirring often). Add remaining ingredients.", "Heat to boiling.", "Return chicken to skillet.", "Cover; cook over low heat 5 minutes or until chicken is no longer pink, stirring occasionally.", "Serves 4."]',
                                   '["2 Tbsp. margarine", "4 skinless, boneless chicken breast halves", "1 1/2 c. sliced mushroom", "1 small onion, sliced", "1/8 tsp. garlic powder or 1 clove garlic, minced", "1 can (10 3/4 oz.) cream of mushroom soup", "1/2 c. milk", "2 Tbsp. dry sherry (optional)", "1/8 tsp. pepper"]',
                                   ARRAY ['margarine', 'skinless', 'mushroom', 'onion', 'garlic', 'cream of mushroom soup', 'milk', 'sherry', 'pepper']);
select cooking_camel_schema.insert('Sweet And Sour Red Cabbage',
                                   '["In a pot of water with 1 tablespoon salt, boil shredded cabbage until just tender.", "Cook it quickly, perhaps 10 minutes at most, to retain its Vitamin C.", "Drain; stir in chopped onion that has been glaceed in a nonstick frypan.", "Add salt, pepper, sugar and vinegar; stir at least two minutes until the vinegar permeates the cabbage, which will become limp.", "Serve hot with Best Herbed Pork Roast."]',
                                   '["1 head red cabbage, cut into small pieces", "1 Tbsp. salt", "1 tsp. salt", "1 tsp. pepper", "1 Tbsp. sugar", "1/2 c. cider vinegar", "caraway seed to taste", "1 onion, chopped"]',
                                   ARRAY ['red cabbage', 'salt', 'salt', 'pepper', 'sugar', 'cider vinegar', 'caraway', 'onion']);
select cooking_camel_schema.insert('Hot Rolls',
                                   '["Use 1/2 cup water to melt yeast.", "Add remainder of water to other 4 ingredients.", "Mix well; knead in enough flour as for biscuits.", "Put in a greased bowl with Crisco and let rise until double in bulk.", "Grease top of dough with Crisco.", "When dough has doubled, make out rolls.", "Put in greased pan and let rise.", "Bake in moderate oven until brown."]',
                                   '["1 1/2 c. warm water", "1 pkg. dry yeast", "3 1/2 tsp. sugar", "1 tsp. salt", "3 tsp. melted Crisco", "4 c. plain flour"]',
                                   ARRAY ['water', 'yeast', 'sugar', 'salt', 'melted Crisco', 'flour']);
select cooking_camel_schema.insert('Chicken Casserole',
                                   '["Spread rice in bottom of a 9 x 13-inch glass casserole dish. Sprinkle onion soup mix on top.", "Lay chicken pieces on top and spoon mushroom soup over all.", "Pour water around chicken pieces. Cover with foil and bake at 325\u00b0 for 1 1/2 hours. Take foil off the last 1/2 hour.", "Check liquid content and add, if necessary."]',
                                   '["1 1/2 c. uncooked rice", "1 envelope onion soup mix", "1 can cream of mushroom soup", "1 1/2 c. hot water", "8 chicken breasts or thighs"]',
                                   ARRAY ['rice', 'onion soup', 'cream of mushroom soup', 'water', 'chicken']);
select cooking_camel_schema.insert('Raisin Walnut Shortbread Bars',
                                   '["Heat oven to 350\u00b0.", "Lightly grease an 8-inch square pan. Combine flour and sugar.", "Using pastry blender or fork, cut in margarine until mixture resembles fine meal.", "Press into greased pan.", "Bake for 20 minutes, or just until edges are golden."]',
                                   '["1 1/4 c. all-purpose flour", "1/2 c. sugar", "1/2 c. butter or margarine", "2 eggs", "1/2 c. firmly packed brown sugar", "1 tsp. vanilla", "1/8 tsp. baking soda", "1 c. chopped walnuts", "1 c. raisins", "1/2 c. flaked coconut (optional)"]',
                                   ARRAY ['flour', 'sugar', 'butter', 'eggs', 'brown sugar', 'vanilla', 'baking soda', 'walnuts', 'raisins', 'flaked coconut']);
select cooking_camel_schema.insert('Pineapple Parfait Pie',
                                   '["Heat 3/4 cup liquid from pineapple plus water (if needed) to boiling.", "Remove from heat.", "Add Jell-O.", "Dissolve.", "Add ice cream until melted.", "Chill until thickened (10 to 15 minutes).", "Fold in pineapple.", "Turn into pie shell.", "Chill until firm, about 20 minutes.", "Top with Cool Whip."]',
                                   '["1 (9-inch) baked pie shell", "No. 2 can crushed pineapple, drained", "1 pkg. lemon Jell-O", "1 pt. vanilla ice cream", "Cool Whip"]',
                                   ARRAY ['shell', 'No', 'lemon Jell-O', 'vanilla ice cream']);
select cooking_camel_schema.insert('Cherry Supreme',
                                   '["Mix graham cracker crumbs and white sugar together.", "Melt butter and pour over the sugar and crumbs; press into a cake pan. Stir and soften cream cheese, powdered sugar and Cool Whip until it is light and fluffy.", "Add to cool crust, then pour the cherry filling on top of the cream cheese.", "Store in refrigerator overnight."]',
                                   '["2 c. graham cracker crumbs", "1/4 c. white sugar", "1 stick butter", "1 can cherry pie filling", "1 small tub Cool Whip", "1/2 c. powdered sugar", "1 pkg. cream cheese"]',
                                   ARRAY ['graham cracker crumbs', 'white sugar', 'butter', 'cherry pie filling', 'powdered sugar', 'cream cheese']);
select cooking_camel_schema.insert('Red Beet Cake',
                                   '["Mix all together.", "Bake at 350\u00b0 for 25 to 35 minutes until done in center."]',
                                   '["1 1/2 c. sugar", "3 eggs", "1 1/2 c. cooked beets, mashed", "1 c. Crisco oil", "2 squares unsweetened chocolate, melted", "1 1/3 c. flour", "1 1/3 tsp. soda", "1/2 tsp. salt", "1 tsp. vanilla"]',
                                   ARRAY ['sugar', 'eggs', 'Crisco oil', 'chocolate', 'flour', 'soda', 'salt', 'vanilla']);
select cooking_camel_schema.insert('Reuben Casserole',
                                   '["Spread sauerkraut in baking dish.", "Top with sliced tomato, dressing and corned beef.", "Sprinkle with cheese and caraway seed. Toss rye bread crumbs with butter and sprinkle over casserole. Bake, uncovered, at 375\u00b0 for 20 to 25 minutes."]',
                                   '["1 (7 oz.) can sauerkraut, drained", "1 small tomato, sliced", "2 Tbsp. Thousand Island dressing", "1 (4 oz.) pkg. sliced corned beef, cut in bite size pieces", "3/4 c. Swiss cheese, shredded", "1/8 tsp. caraway seed", "1 c. rye bread crumbs (soft)", "1 Tbsp. butter or margarine"]',
                                   ARRAY ['sauerkraut', 'tomato', 'beef', 'Swiss cheese', 'caraway seed', 'rye bread', 'butter']);
select cooking_camel_schema.insert('Potato Casserole',
                                   '["Mix sour cream, Cheez Whiz, onions and parsley.", "Fold in potatoes.", "Fold in sausage.", "Pour in large baking pan.", "Bake at 350\u00b0 for 45 minutes.", "Top with red pepper and a few sausage slices for looks."]',
                                   '["4 lb. Irish potatoes (boil, peel and slice in 1/4 slices)", "16 oz. (large) sour cream", "16 oz. (large) Cheez Whiz", "2 Tbsp. minced onions", "1 Tbsp. dried parsley", "1 lb. precooked sausage (sliced in diced cuts)"]',
                                   ARRAY ['Irish potatoes', 'sour cream', 'onions', 'parsley', 'sausage']);
select cooking_camel_schema.insert('Carrot-Pineapple Bread',
                                   '["Mix all ingredients well.", "Bake 1 hour at 350\u00b0 in two loaf pans lined with waxed paper or foil."]',
                                   '["3 beaten eggs", "2 c. sugar", "1 c. oil", "1 small can crushed pineapple", "2 tsp. vanilla", "1 c. grated carrots", "1 1/2 tsp. cinnamon", "1 tsp. soda", "1/4 tsp. salt", "3 c. flour", "1 c. chopped nuts"]',
                                   ARRAY ['eggs', 'sugar', 'oil', 'pineapple', 'vanilla', 'carrots', 'cinnamon', 'soda', 'salt', 'flour', 'nuts']);
select cooking_camel_schema.insert('Easy Chicken And Dumplings',
                                   '["Layer chicken in bottom of casserole dish and pour melted butter or margarine over chicken.", "Next, mix flour with milk and pour over chicken.", "Mix soup and broth and pour over top of casserole and gently stir across top; smooth out.", "Bake at 350\u00b0 for 45 minutes or until golden brown and done in center."]',
                                   '["1 chicken, cooked and cut into small pieces", "1/4 stick margarine or butter", "2 c. chicken broth", "1 c. milk", "1 can chicken soup", "1 c. self-rising flour", "salt and pepper to taste"]',
                                   ARRAY ['chicken', 'margarine', 'chicken broth', 'milk', 'chicken soup', 'flour', 'salt']);
select cooking_camel_schema.insert('"Delicious" Scalloped Potatoes(Without Cheese)  ',
                                   '["Slice peeled potatoes in round, pretty thin slices.", "Layer in a deep casserole dish with butter and salt.", "Pour can of milk over the potatoes.", "Make sure they are completely covered with milk. Bake, uncovered, for about 1 hour at 475\u00b0."]',
                                   '["6 large potatoes", "2 cans evaporated milk", "3/4 stick margarine", "salt and pepper"]',
                                   ARRAY ['potatoes', 'milk', 'margarine', 'salt']);
select cooking_camel_schema.insert('Peanut Butter Oat Cookies',
                                   '["Cream butter and brown sugar.", "Add corn syrup.", "Mix well. Spread mixture evenly in greased 13 x 9-inch cake pan.", "Bake at 350\u00b0 for 15 minutes.", "Cool slightly.", "Spread peanut butter evenly over top.", "Melt chocolate chips and butter together until smooth. Drizzle over peanut butter.", "Cool to set, then cut in squares."]',
                                   '["1/2 c. butter", "1 c. packed brown sugar", "1/2 c. corn syrup", "1 tsp. salt", "4 c. quick cooking oats", "1/2 c. peanut butter", "1/2 c. chocolate chips", "1 1/2 tsp. butter", "2 tsp. vanilla"]',
                                   ARRAY ['butter', 'brown sugar', 'corn syrup', 'salt', 'cooking oats', 'peanut butter', 'chocolate chips', 'butter', 'vanilla']);
select cooking_camel_schema.insert('Cherry Salad',
                                   '["Mix all ingredients together and refrigerate 1 hour before serving."]',
                                   '["2 cans cherry pie filling", "1 can crushed pineapple, not drained", "1/2 c. pecans", "1 c. miniature marshmallows", "1 large container Cool Whip", "1 can Eagle Brand milk"]',
                                   ARRAY ['cherry pie filling', 'pineapple', 'pecans', 'marshmallows', 'milk']);
select cooking_camel_schema.insert('Scalloped Oysters',
                                   '["Drain oysters, saving liquid.", "Combine crumbs, butter, salt and pepper.", "Spread 1/3 of butter and crumbs in greased casserole (2-quart).", "Cover with 1/2 of the oysters.", "Using another 1/3 of buttered crumbs, spread second layer and add remaining oysters. Finish with last 1/3 of buttered crumbs on top.", "Combine liquid ingredients and pour over top.", "Bake at 350\u00b0 for 40 minutes."]',
                                   '["1 pt. oysters", "2 c. cracker crumbs (Ritz)", "1/2 c. melted butter", "1/2 tsp. salt", "dash of pepper", "3/4 c. cream", "1/4 c. oyster liquid", "1/4 tsp. Worcestershire sauce"]',
                                   ARRAY ['oysters', 'cracker crumbs', 'butter', 'salt', 'pepper', 'cream', 'oyster liquid', 'Worcestershire sauce']);
select cooking_camel_schema.insert('Pie Crust',
                                   '["Cut shortening and butter into flour and salt mixture.", "Slowly add water while mixing with a fork (depending on weather, slightly more or less water can be used).", "Form into ball.", "Cut in half for 2 crusts.", "Roll out, using only a little flour.", "For baked pie shells: prick with fork and bake 8 minutes at 475\u00b0."]',
                                   '["2/3 c. shortening", "2 Tbsp. butter, softened", "2 c. flour", "1 tsp. salt", "1/4 c. cold water"]',
                                   ARRAY ['shortening', 'butter', 'flour', 'salt', 'cold water']);
select cooking_camel_schema.insert('Oatmeal Cake',
                                   '["Make oatmeal.", "Cool about 20 minutes.", "Add remaining ingredients; beat until well blended.", "Bake in a 9 x 13-inch pan at 350\u00b0 for 35 to 40 minutes."]',
                                   '["1 1/2 c. boiling water", "1 c. oatmeal", "1/2 c. butter", "1 c. white sugar", "1 c. brown sugar", "2 eggs", "1 1/2 c. flour", "1/2 tsp. salt", "1 tsp. cinnamon", "1 tsp. soda", "1 tsp. baking powder", "1 tsp. vanilla"]',
                                   ARRAY ['boiling water', 'oatmeal', 'butter', 'white sugar', 'brown sugar', 'eggs', 'flour', 'salt', 'cinnamon', 'soda', 'baking powder', 'vanilla']);
select cooking_camel_schema.insert('Candle Salad',
                                   '["Put one lettuce leaf on each plate.", "Lay a pineapple slice on top of each lettuce leaf.", "Stand 1/2 a banana in the hole of each pineapple.", "Top the banana with a bit of mayonnaise.", "Put a cherry on top of the mayonnaise."]',
                                   '["lettuce", "pineapple slices", "banana", "mayonnaise", "cherries"]',
                                   ARRAY ['pineapple', 'banana', 'mayonnaise', 'cherries']);
select cooking_camel_schema.insert('Salmon Croquettes',
                                   '["Mix salmon, potatoes, onion, egg and pepper until blended. Form into 8 patties, each about 3/4-inch thick.", "Spread crumbs on waxed paper.", "Gently press patties in crumbs to coat.", "Heat oil in a large nonstick skillet.", "Add patties and cook over medium heat about 4 minutes per side until heated through, golden and crisp. Serves 4."]',
                                   '["1 (14 3/4 oz.) can pink salmon, drained", "1 1/2 c. mashed potatoes", "1 small onion, grated", "1 large egg", "1/2 tsp. pepper", "1/4 c. packaged bread crumbs", "3 Tbsp. vegetable oil"]',
                                   ARRAY ['pink salmon', 'potatoes', 'onion', 'egg', 'pepper', 'bread crumbs', 'vegetable oil']);
select cooking_camel_schema.insert('Croquettes(Chicken, Fish Or Meat)  ',
                                   '["Cut meat or fish in small pieces; add seasonings desired and croquette sauce.", "Mix together and shape.", "If mixture is not stiff enough to shape, chill in refrigerator half an hour."]',
                                   '["2 c. chicken, fish or meat", "1 c. croquette sauce", "1 egg", "3/4 c. breadcrumbs", "salt to taste", "pepper to taste"]',
                                   ARRAY ['chicken', 'croquette sauce', 'egg', 'breadcrumbs', 'salt', 'pepper']);
select cooking_camel_schema.insert('Corn Relish]',
                                   '["Combine ingredients and boil uncovered 15 minutes.", "Thicken with a small amount of flour if the mixture is too thin.", "Ladle into warm canning jars, leaving 1/8-inch headspace.", "Seal immediately.", "Process in boiling water bath 15 minutes.", "Very good with roast, men love it!"]',
                                   '["1 large can corn", "6 onions, chopped", "1 stalk celery, chopped", "1 pt. white vinegar", "3 red sweet peppers, chopped", "3 green sweet peppers, chopped", "2 c. sugar", "1 tsp. turmeric", "1 Tbsp. dry mustard", "1 Tbsp. celery salt", "2 Tbsp. salt"]',
                                   ARRAY ['corn', 'onions', 'celery', 'white vinegar', 'red sweet peppers', 'green sweet peppers', 'sugar', 'turmeric', 'mustard', 'celery salt', 'salt']);
select cooking_camel_schema.insert('FlossieS Gingerbread',
                                   '["Mix in order given and bake in loaf pan in moderate oven, 350\u00b0."]',
                                   '["1/2 c. sugar", "1/2 c. shortening", "1 egg", "1 1/2 tsp. soda", "1 tsp. cinnamon", "1 tsp. ginger", "1/2 tsp. salt", "2 1/2 c. flour", "1 c. hot water", "1 c. molasses"]',
                                   ARRAY ['sugar', 'shortening', 'egg', 'soda', 'cinnamon', 'ginger', 'salt', 'flour', 'water', 'molasses']);
select cooking_camel_schema.insert('Vanilla Wafer Cake',
                                   '["Cream butter and sugar together until light and fluffy.", "Add eggs, one at a time, beating well after each addition.", "Add crushed wafers alternately with milk.", "Add coconut and pecans and mix well. Pour into a 12 cup tube pan greased with nonstick spray.", "Cook completely before removing from pan.", "May be glazed with powdered sugar and topped with pecan halves and maraschino cherries. Freezes well."]',
                                   '["2 sticks butter (do not substitute)", "2 c. granulated sugar", "6 eggs", "1/2 c. milk", "12 oz. box vanilla wafers, crushed", "7 oz. flaked coconut", "1 c. chopped pecans"]',
                                   ARRAY ['butter', 'sugar', 'eggs', 'milk', 'vanilla wafers', 'flaked coconut', 'pecans']);
select cooking_camel_schema.insert('Double Baked Potatoes',
                                   '["Wash the potatoes, rub them with oil and bake at 350\u00b0 until done.", "Let them cool and cut in half lengthwise, leaving about 1/4-inch around the shell.", "Scoop out the potato.", "Set the shells aside."]',
                                   '["6 medium size baking potatoes", "1 medium to large onion, diced", "1 (16 oz.) pkg. bacon, cooked and crumbled", "1 1/2 c. cooked, smoked ham, cut in small cubes", "1 1/2 c. cheese (I use part Mozzarella and part Cheddar)", "2 Tbsp. butter or margarine", "1/4 c. milk"]',
                                   ARRAY ['potatoes', 'onion', 'bacon', 'ham', 'cheese', 'butter', 'milk']);
select cooking_camel_schema.insert('Crabmeat Au Gratin',
                                   '["Mix everything together, except cheese and crumbs, in casserole.", "Top with cheese, then with bread crumbs.", "Bake at 350\u00b0 for 35 minutes."]',
                                   '["1 can cream of shrimp soup", "1/2 can milk (use soup can)", "1 lb. faux crabmeat", "4 c. celery, chopped", "1/2 c. green pepper, chopped", "2 pimentos, chopped", "2 Tbsp. onions, chopped", "1/3 c. slivered almonds", "4 hard-cooked eggs, chopped", "1 c. shredded sharp Cheddar cheese", "buttered bread crumbs"]',
                                   ARRAY ['cream of shrimp soup', 'milk', 'faux crabmeat', 'celery', 'green pepper', 'pimentos', 'onions', 'almonds', 'eggs', 'Cheddar cheese', 'buttered bread crumbs']);
select cooking_camel_schema.insert('Hobo Stew',
                                   '["In skillet at medium heat, brown ground beef; drain.", "Add catsup, mustard, barbecue sauce, potatoes, pork and beans, corn and onion flakes.", "Reduce to low heat; simmer for 15 to 20 minutes or until heated through."]',
                                   '["2 lb. ground beef", "1/4 c. catsup", "1/4 c. mustard", "1/4 c. barbecue sauce", "2 (16 oz.) cans sliced potatoes, drained", "2 (16 oz.) cans pork and beans", "1 (16 oz.) can whole kernel corn, drained", "2 Tbsp. minced onion flakes"]',
                                   ARRAY ['ground beef', 'catsup', 'mustard', 'barbecue sauce', 'potatoes', 'pork', 'whole kernel corn', 'onion flakes']);
select cooking_camel_schema.insert('Lemon Crunch', '["Preheat oven to 350\u00b0."]',
                                   '["1 stick butter", "1 c. flour", "1/2 c. pecans, chopped", "1 (8 oz.) pkg. cream cheese, softened", "1 c. confectioners sugar", "1 small container Cool Whip", "2 small pkg. lemon instant pudding (can also use chocolate)", "3 c. milk"]',
                                   ARRAY ['butter', 'flour', 'pecans', 'cream cheese', 'confectioners sugar', 'lemon instant pudding', 'milk']);
select cooking_camel_schema.insert('No Name Cake',
                                   '["Beat cake mix, milk, eggs and oil together. Add can of coconut pecan icing and mix well. Add pecans. Grease and flour a Bundt pan. Bake at 340\u00b0 for 45 minutes, then turn the oven down to 315\u00b0 and bake for 25 more minutes. Do not open the door during the first 45 minutes."]',
                                   '["1 box Duncan Hines butter recipe cake mix", "1 c. milk", "4 eggs", "3/4 c. oil", "1 can ready to spread coconut pecan icing", "1 c. pecans"]',
                                   ARRAY ['butter', 'milk', 'eggs', 'oil', 'ready', 'pecans']);
select cooking_camel_schema.insert('Gold Rush Brunch',
                                   '["Prepare potatoes according to directions.", "In large saucepan melt butter; blend in flour, salt and pepper.", "Add milk and stir until thick and bubbly.", "Remove from heat.", "Add sour cream, parsley and potatoes.", "Place mixture in 9 x 13-inch baking pan.", "Arrange bacon in a row down center, overlapping.", "Bake at 350\u00b0 for 20 minutes.", "Make a depression in mixture on each side of bacon.", "Slip 1 egg into each depression.", "Bake until eggs are set, 10 to 12 minutes.", "Serves 8."]',
                                   '["1 pkg. potatoes OBrien or homemade", "1/4 c. butter", "1/4 c. flour", "2 c. milk", "1 c. sour cream", "salt and pepper to taste", "parsley", "8 slices Canadian bacon", "8 eggs"]',
                                   ARRAY ['potatoes OBrien', 'butter', 'flour', 'milk', 'sour cream', 'salt', 'parsley', 'bacon', 'eggs']);
select cooking_camel_schema.insert('Pot Roast', '["You will need 1 large iron kettle (pot) or 2 iron skillets."]',
                                   '["chuck roast (5 lb. +/-, blade in or out)", "ginger", "garlic salt", "pepper", "paprika", "1 can tomato paste"]',
                                   ARRAY ['chuck roast', 'ginger', 'garlic', 'pepper', 'paprika', 'tomato paste']);
select cooking_camel_schema.insert('Ham Cheese Oven Omelet',
                                   '["Beat eggs, milk and seasoned salt.", "Stir in remaining ingredients.", "Pour into greased oblong 12 x 7 1/2 x 2-inch dish or square 8 x 8 x 2-inch baking dish.", "Cook, uncovered, in 325\u00b0 oven until omelet is set and top is golden brown, 40 to 45 minutes."]',
                                   '["8 eggs", "1 c. milk", "1 (3 oz.) pkg. smoked, sliced ham, beef or corned beef, torn into small pieces", "3 Tbsp. finely chopped onion", "1/2 tsp. seasoned salt", "1 c. Cheddar cheese"]',
                                   ARRAY ['eggs', 'milk', 'beef', 'onion', 'salt', 'Cheddar cheese']);
select cooking_camel_schema.insert('Never Fail Rolls',
                                   '["Mix all ingredients; put in refrigerator for at least 2 hours. (Can be mixed at night and next day rolled out.", "Dough will be sticky.)", "Divide dough in 3 to 4 parts.", "Roll in circle; cut into pie shaped wedges.", "Roll up from the wide end to the narrow; place on oiled cookie sheet.", "Let rise.", "Bake at 375\u00b0 for 18 minutes. Enjoy."]',
                                   '["1 c. butter", "3/4 c. sugar", "1 c. boiling water (to melt margarine)", "1 c. lukewarm water (for yeast)", "2 pkg. yeast (dry)", "2 eggs, beaten", "1 tsp. salt", "6 1/2 c. flour (about)"]',
                                   ARRAY ['butter', 'sugar', 'boiling water', 'water', 'yeast', 'eggs', 'salt', 'flour']);
select cooking_camel_schema.insert('Taco Casserole',
                                   '["Preheat oven to 350\u00b0.", "In a large skillet, brown ground beef; remove from heat and drain off any excess liquid. Add onion, garlic powder, taco seasoning mix and tomato sauce; mix and set aside."]',
                                   '["1 lb. ground beef", "1 small onion, chopped", "1/2 tsp. garlic powder", "1 envelope taco seasoning mix", "1 (8 oz.) can tomato sauce", "1 c. sour cream", "1 c. cottage cheese", "2 c. crushed tortilla chips", "2 c. shredded Cheddar or Monterey Jack cheese"]',
                                   ARRAY ['ground beef', 'onion', 'garlic powder', 'taco', 'tomato sauce', 'sour cream', 'cottage cheese', 'tortilla chips', 'cheese']);
select cooking_camel_schema.insert('Warm Crabmeat Dip',
                                   '["Mix all together except Parmesan cheese.", "Put in small, shallow pan.", "Sprinkle", "cheese", "on\ttop.", "Bake", "at 400\u00b0 for 30 minutes. Serve with crackers."]',
                                   '["1 can crab", "1 (8 oz.) cream cheese", "2 Tbsp. mayo", "3 tsp. lemon juice", "3 tsp. Worcestershire sauce", "1/16 tsp. garlic powder", "1 Tbsp. finely chopped onion", "Parmesan cheese"]',
                                   ARRAY ['crab', 'cream cheese', 'mayo', 'lemon juice', 'Worcestershire sauce', 'garlic powder', 'onion', 'Parmesan cheese']);
select cooking_camel_schema.insert('Herb Butter', '["Blend all together and chill overnight."]',
                                   '["2 Tbsp. dried herbs: equal parts of parsley, tarragon, chives and/or basil", "1/2 c. margarine"]',
                                   ARRAY ['herbs', 'margarine']);
select cooking_camel_schema.insert('Good N Easy Yeast Rolls',
                                   '["In a saucepan combine sugar.", "Melt over medium heat the shortening and 1 cup hot water.", "Set aside to cool.", "Dissolve yeast in small bowl with 1 cup warm water (not hot).", "Beat eggs in a large bowl.", "Sift flour with salt mixed in."]',
                                   '["2/3 c. sugar plus 1 Tbsp.", "1 scant c. shortening", "1 c. hot water", "2 pkg. yeast, dissolved in 1 c. warm water (not hot)", "2 eggs", "6 c. plain flour with 1 tsp. salt mixed in"]',
                                   ARRAY ['sugar', 'shortening', 'water', 'yeast', 'eggs', 'flour']);
select cooking_camel_schema.insert('Southwestern Skillet',
                                   '["In a large skillet, cook ground beef and onion.", "Drain fat. Stir in undrained tomatoes, uncooked rice, green pepper, olives, chili powder, garlic salt, salt and water.", "Bring to a boil. Reduce heat.", "Cover and simmer for 20 minutes, stirring occasionally.", "Top with cheese.", "Cover and heat for about 3 minutes or until cheese melts."]',
                                   '["1 lb. ground beef", "1/2 c. minced onion", "1 (14 1/2 oz.) can tomatoes, chopped", "3/4 c. Minute rice", "3 Tbsp. chopped green pepper", "1/2 c. sliced stuffed olives", "1 1/2 tsp. chili powder", "1/2 tsp. garlic salt", "1/2 tsp. salt", "1 c. water", "1 c. shredded Cheddar cheese"]',
                                   ARRAY ['ground beef', 'onion', 'tomatoes', 'rice', 'green pepper', 'olives', 'chili powder', 'garlic salt', 'salt', 'water', 'Cheddar cheese']);
select cooking_camel_schema.insert('Delicious Baked Potato Dish',
                                   '["Wash and peel potatoes, slicing very thin.", "Use 1 tablespoon of the butter and place in a shallow baking dish.", "Evenly layer one half of the potatoes in the dish, sprinkling lightly with salt and add 1/2 of the cheese.", "Layer remaining potatoes, lightly salt and place remaining cheese on top.", "Sprinkle with chopped chives and bake at 450\u00b0", "for 45 minutes until potatoes are tender and browned on top."]',
                                   '["4 large baking potatoes", "2 Tbsp. butter or margarine", "1/2 c. shredded Cheddar cheese", "1 c. whipping cream", "1 tsp. chopped chives"]',
                                   ARRAY ['baking potatoes', 'butter', 'Cheddar cheese', 'whipping cream', 'chives']);
select cooking_camel_schema.insert('Quick Cream Of Broccoli Soup',
                                   '["In medium saucepan bring 3 cups milk and broccoli to boiling, then simmer, stirring occasionally for 5 minutes.", "Stir in soup mix and flour blended with remaining milk.", "Bring to boiling point, then simmer, stirring occasionally, 10 minutes or until soup is slightly thickened and broccoli is tender."]',
                                   '["1 (10 oz.) pkg. frozen chopped broccoli, partially thawed", "1 envelope Lipton chicken soup mix with diced white chicken meat", "3 1/2 c. milk", "1 Tbsp. flour"]',
                                   ARRAY ['broccoli', 'chicken soup', 'milk', 'flour']);
select cooking_camel_schema.insert('Cabbage Rolls',
                                   '["Wilt cabbage leaves in hot water.", "Combine all ingredients and mix thoroughly.", "Form into rolls and wrap in cabbage leaves. Place cabbage rolls in a cooker.", "Add tomatoes and cook over medium heat until hamburger is done and cabbage leaves are tender. Delicious."]',
                                   '["1 head cabbage", "1 lb. hamburger", "1 c. cooked rice", "1/2 tsp. pepper", "1 egg", "1 tsp. salt", "chopped onion", "1 can tomatoes"]',
                                   ARRAY ['cabbage', 'hamburger', 'rice', 'pepper', 'egg', 'salt', 'onion', 'tomatoes']);
select cooking_camel_schema.insert('Coconut Custard Pie',
                                   '["Put all ingredients into blender and blend well 1 to 3 minutes.", "Pour into an ungreased pie pan and bake at 350\u00b0 for 45 minutes."]',
                                   '["4 eggs", "2 c. milk", "1/2 c. Bisquick", "1/3 c. softened oleo", "1 tsp. vanilla", "1 can coconut", "3/4 c. sugar"]',
                                   ARRAY ['eggs', 'milk', 'Bisquick', 'oleo', 'vanilla', 'coconut', 'sugar']);
select cooking_camel_schema.insert('Zucchini Pizzas',
                                   '["Combine spaghetti sauce, onions, black pepper and oregano in a small bowl.", "Combine Mozzarella cheese and Parmesan cheese.", "Place zucchini coins on a cookie sheet which has been coated with vegetable cooking spray (approximately 1-inch apart).", "Top with sauce, then a mushroom slice.", "Sprinkle with cheese mixture. Broil until hot and bubbly."]',
                                   '["3/4 c. spaghetti sauce (Garden-Style)", "1/2 c. (2 oz.) shredded part-skim Mozzarella cheese", "2 Tbsp. grated Parmesan cheese", "2 Tbsp. minced onions", "1/4 tsp. fresh ground black pepper", "1/4 tsp. dried oregano", "24 (1/2-inch) slices fresh zucchini", "24 slices fresh mushrooms"]',
                                   ARRAY ['spaghetti sauce', 'Mozzarella cheese', 'Parmesan cheese', 'onions', 'fresh ground black pepper', 'oregano', 'zucchini', 'mushrooms']);
select cooking_camel_schema.insert('School Girl Pickles(Sweet Spear)  ',
                                   '["Soak cucumbers 2 weeks in salt water.", "After 2 weeks, wash and soak overnight in plain water.", "Cut lengthwise and soak in alum water for 6 hours.", "Drain off alum water and slightly rinse with cold water.", "Heat enough vinegar to cover to the boiling point. Cover cucumbers and let stand for 24 hours.", "Drain off vinegar (dont wash).", "Place layer of cucumbers and a layer of sugar until all are used.", "Add spices tied in a bag in the middle of cucumbers and let stand for 3 days.", "They are now ready to put in jars or any large covered container."]',
                                   '["14 tsp. alum", "12 lb. cucumbers (whole)", "9 c. water", "1 c. salt", "8 lb. sugar", "pickling spice"]',
                                   ARRAY ['alum', 'cucumbers', 'water', 'salt', 'sugar', 'pickling spice']);
select cooking_camel_schema.insert('Earthquake Cake',
                                   '["Cover the bottom of a 13 x 9-inch pan with coconut.", "Sprinkle pecans over coconut.", "Mix the cake as box directs and pour over coconut and pecans.", "Mix cream cheese, melted butter and powdered sugar.", "Mixture should be slightly thick (if more powdered sugar is needed, add gradually until you feel mixture is thick enough). Drop over cake and bake until done at 350\u00b0.", "Cake will crack open. Frost with Coca-Cola Icing."]',
                                   '["1 box German chocolate cake mix", "8 oz. pkg. cream cheese", "1 stick butter", "3 c. powdered sugar", "3/4 c. pecans, chopped", "1 c. coconut"]',
                                   ARRAY ['chocolate cake', 'cream cheese', 'butter', 'powdered sugar', 'pecans', 'coconut']);
select cooking_camel_schema.insert('Mayonnaise Cake',
                                   '["Mix all together.", "Bake at 350\u00b0 for 20 to 35 minutes.", "Test with toothpick."]',
                                   '["2 c. flour", "4 Tbsp. cocoa", "1 c. sugar", "pinch of salt", "1 c. lukewarm water", "2 tsp. baking soda, dissolved in the warm water", "1 c. mayonnaise"]',
                                   ARRAY ['flour', 'cocoa', 'sugar', 'salt', 'water', 'baking soda', 'mayonnaise']);
select cooking_camel_schema.insert('White Pear Cake(Quick, Easy And Delicious!)  ',
                                   '["High altitude:", "Add 1 tbsp flour and 1/4 C sugar."]',
                                   '["1 white batter cake mix", "1 1 lb can pear halves, undrained", "2 egg whites", "1 whole egg"]',
                                   ARRAY ['white batter', 'pear halves', 'egg whites', 'egg']);
select cooking_camel_schema.insert('Party Pink Punch',
                                   '["Blend first 4 ingredients.", "Freeze.", "Take out of freezer for 2 hours before serving.", "Break into mush.", "Add chilled ginger ale at last minute so that it does not get flat."]',
                                   '["1 (46 oz.) can pineapple juice", "1 c. sugar", "1 (6 oz.) can frozen lemonade", "1 (48 oz.) bottle cranberry juice", "2 liters ginger ale, chilled"]',
                                   ARRAY ['pineapple juice', 'sugar', 'frozen lemonade', 'cranberry juice', 'liters ginger ale']);
select cooking_camel_schema.insert('Country Style Beef And Macaroni',
                                   '["Cook and drain macaroni.", "Melt butter and next 3 ingredients. Cook over medium heat until beef is browned.", "Add macaroni and remaining ingredients. Mix well and heat to serving temperature."]',
                                   '["8 oz. macaroni", "2 medium onions, sliced", "1 pkg. (10 oz.) frozen peas, cooked and drained", "salt and pepper"]',
                                   ARRAY ['macaroni', 'onions', 'frozen peas', 'salt']);
select cooking_camel_schema.insert('Peanut Butter Cream Pie',
                                   '["Combine cream cheese, milk and peanut butter until smooth. Stir in sugar.", "Mix in Cool Whip.", "Pour into pie shell. Refrigerate several hours."]',
                                   '["3 oz. fat-free cream cheese", "2 Tbsp. skim milk", "1 c. powdered sugar", "1/2 c. reduced-fat peanut butter", "large container Cool Whip lite", "low-fat baked pie shell"]',
                                   ARRAY ['cream cheese', 'milk', 'powdered sugar', 'peanut butter', 'lite', 'low-fat baked pie shell']);
select cooking_camel_schema.insert('Scalloped Corn',
                                   '["Combine ingredients and pour into 1 quart casserole dish. Bake at 350 degrees for about 35 minutes or until knife inserted near the center comes out clean. Makes 4 servings."]',
                                   '["dash of pepper", "1 beaten egg", "1/2 cup milk", "1 - 8-3/4 ounce can cream-style corn", "1 - 7 ounce can whole kernel corn, drained"]',
                                   ARRAY ['pepper', 'egg', 'milk', 'cream-style', 'whole kernel corn']);
select cooking_camel_schema.insert('Waldrop Banana Pudding',
                                   '["Mix first 6 ingredients together; beat well.", "Stir constantly when cooking; cook over medium heat until mixture thickens. Remove quickly from heat; layer in bowl with banana slices and vanilla wafers (best warm)."]',
                                   '["2 c. milk", "1 c. sugar", "1/2 c. flour", "2 eggs", "1 tsp. vanilla", "pinch of salt", "bananas", "vanilla wafers"]',
                                   ARRAY ['milk', 'sugar', 'flour', 'eggs', 'vanilla', 'salt', 'bananas', 'vanilla wafers']);
select cooking_camel_schema.insert('Hungarian Goulash',
                                   '["Cook and stir beef, onion and garlic in shortening until beef is brown; drain.", "Stir in 1 1/2 cups water, catsup, Worcestershire sauce, brown sugar, salt, paprika, mustard and red pepper.", "Heat to boiling.", "Reduce heat.", "Cover and simmer until beef is tender, 2 to 2 1/2 hours.", "Can also put in crock-pot on low for 8 to 9 hours. Shake 1/4 cup cold water and flour in tightly covered container. Stir gradually into beef mixture.", "Heat to boiling, stirring constantly.", "Boil and stir 1 minute.", "Serve over hot noodles."]',
                                   '["2 lb. beef for stew, cubed", "1 medium onion, sliced", "1 small clove garlic", "1/4 c. shortening", "1 1/2 c. water", "3/4 c. catsup", "2 Tbsp. Worcestershire sauce", "1 Tbsp. packed brown sugar", "2 tsp. salt", "2 tsp. paprika", "1/2 tsp. dry mustard", "dash of cayenne red pepper", "1/4 c. cold water", "2 Tbsp. flour"]',
                                   ARRAY ['beef for stew', 'onion', 'clove garlic', 'shortening', 'water', 'catsup', 'Worcestershire sauce', 'brown sugar', 'salt', 'paprika', 'dry mustard', 'cayenne red pepper', 'cold water', 'flour']);
select cooking_camel_schema.insert('Plain Pound Cake',
                                   '["Mix all ingredients in a mixing bowl.", "Pour into pound cake pan. Bake at 300\u00b0 for 1 1/2 hours."]',
                                   '["3 c. sugar", "3 c. Swans Down cake flour", "7 eggs (medium)", "1 c. milk", "1/2 tsp. salt", "1 tsp. vanilla flavoring", "1 tsp. butternut flavoring", "1 1/2 c. Crisco"]',
                                   ARRAY ['sugar', 'Swans', 'eggs', 'milk', 'salt', 'vanilla flavoring', 'butternut flavoring', 'Crisco']);
select cooking_camel_schema.insert('Ham And Country Dumplings',
                                   '["Boil ham bone in large pot; remove bone, putting meat from bone back into the broth.", "Add ham bouillon to flavor."]',
                                   '["ham bone", "ham bouillon", "flour", "2 eggs", "1 c. cold water"]',
                                   ARRAY ['ham bone', 'ham bouillon', 'flour', 'eggs', 'cold water']);
select cooking_camel_schema.insert('Broccoli Rice Casserole',
                                   '["Saute onion and celery in butter until tender.", "Combine onions and celery with remaining ingredients.", "Pour into greased 1 1/2-quart baking dish.", "Bake at 350\u00b0.", "Better if prepared a day ahead.", "Freezes well."]',
                                   '["1 chopped onion", "1 rib chopped celery", "1/2 stick butter", "1 (10 oz.) pkg. frozen broccoli, cooked and well drained", "2 1/2 c. cooked rice", "1 (10 3/4 oz.) can condensed cream of chicken soup", "4 oz. cheez Whiz", "dash of Tabasco", "pepper to taste"]',
                                   ARRAY ['onion', 'celery', 'butter', 'frozen broccoli', 'rice', 'condensed cream', 'cheez Whiz', 'pepper']);
select cooking_camel_schema.insert('Buckeyes(Cookies)  ',
                                   '["Melt oleo and combine with other ingredients.", "Roll into small balls and place on wax paper.", "Then melt chocolate chips and paraffin wax.", "Then dip balls into chocolate mixture, place on wax paper and cool.", "Makes 120 pieces."]',
                                   '["1 (18 oz.) jar crunchy peanut butter", "3 c. Rice Krispies", "1 lb. powdered sugar", "1 stick oleo", "1 (12 oz.) chocolate chips", "1/2 stick paraffin wax"]',
                                   ARRAY ['crunchy peanut butter', 'Rice Krispies', 'powdered sugar', 'oleo', 'chocolate chips', 'paraffin']);
select cooking_camel_schema.insert('Broccoli-Raisin Salad',
                                   '["Mix broccoli, onion, sunflower seeds, raisins and bacon."]',
                                   '["1 bunch broccoli heads", "2 stems green onion (single stalks) or 1/2 medium whole onion", "1/4 c. sunflower seeds", "1/2 c. raisins", "6 slices bacon, fried and cooled", "1/2 c. mayonnaise", "2 Tbsp. vinegar", "1/8 c. sugar"]',
                                   ARRAY ['broccoli heads', 'green onion', 'sunflower seeds', 'raisins', 'bacon', 'mayonnaise', 'vinegar', 'sugar']);
select cooking_camel_schema.insert('Low-Fat "French Fries"',
                                   '["Preheat oven to 425\u00b0.", "Peel potatoes or leave them unpeeled, depending on your preference.", "Cut into two-inch strips.", "Mix garlic powder and salt and set aside.", "Place potatoes into large plastic container; pour oil and pepper over.", "Shake vigorously."]',
                                   '["1 1/2 to 2 lb. baking potatoes", "1/8 to 1/4 tsp. cayenne", "1 to 1 1/2 Tbsp. olive oil", "nonstick cooking spray", "1/3 to 1/2 tsp. garlic powder", "1/4 to 1/2 tsp. salt"]',
                                   ARRAY ['baking potatoes', 'cayenne', 'olive oil', 'nonstick cooking spray', 'garlic powder', 'salt']);
select cooking_camel_schema.insert('Chicken Pot Pie',
                                   '["Grease shallow 2-quart dish.", "Place vegetables and chicken in dish.", "Stir together broth, soup, salt and pepper.", "Pour over chicken.", "Combine flour, milk and margarine.", "Stir until smooth. Pour over mixture.", "Bake in 400\u00b0 oven for 40 to 50 minutes."]',
                                   '["3 c. cooked and diced chicken", "1 small pkg. frozen Veg-All", "1 c. chicken broth", "1 c. cream of celery soup", "1/4 tsp. pepper", "1/2 tsp. salt", "1 c. self-rising flour", "1 c. milk", "1/2 c. margarine, melted"]',
                                   ARRAY ['chicken', 'chicken broth', 'cream of celery soup', 'pepper', 'salt', 'flour', 'milk', 'margarine']);
select cooking_camel_schema.insert('Old-Time Bread Pudding',
                                   '["Grease 1 1/2-quart baking dish.", "Place toast, cut into quarters, in dish.", "Sprinkle raisins over top.", "Combine eggs, sugar, salt, milk, water and vanilla.", "Pour over toast.", "Let stand 10 minutes.", "Sprinkle with sugar and cinnamon.", "Bake at 350\u00b0 for 30 minutes or until knife inserted in center comes out clean. Makes 4 servings."]',
                                   '["4 slices buttered toast", "1/3 c. seedless raisins", "2 eggs, slightly beaten", "1/4 c. sugar", "1/8 tsp. salt", "1 c. Pet milk", "1 c. boiling water", "1 tsp. vanilla", "4 tsp. sugar", "1/4 tsp. cinnamon"]',
                                   ARRAY ['buttered toast', 'raisins', 'eggs', 'sugar', 'salt', 'Pet milk', 'boiling water', 'vanilla', 'sugar', 'cinnamon']);
select cooking_camel_schema.insert('Original Mayfair Dressing',
                                   '["Blend together first 8 ingredients in electric blender until liquid consistency.", "(It is very important to use either a blender or a food processor in order to achieve a smooth, creamy dressing.)", "Then add eggs, one at a time.", "Beat well after each addition.", "Add Mazola oil, a small amount at a time, blending after each addition.", "Makes 1 quart."]',
                                   '["1 (2 oz.) can anchovies", "1 Tbsp. black pepper", "1 Tbsp. Accent", "2 stalks celery", "1 medium onion", "1/4 c. mustard", "1 1/2 cloves garlic", "1 tsp. lemon juice", "3 eggs", "2 c. Mazola oil"]',
                                   ARRAY ['anchovies', 'black pepper', 'Accent', 'stalks celery', 'onion', 'mustard', 'garlic', 'lemon juice', 'eggs', 'oil']);
select cooking_camel_schema.insert('Apple Cake',
                                   '["Beat eggs, sugar and oil.", "Add flour, soda, salt and cinnamon. Then add apples, nuts and coconut.", "Bake at 375\u00b0 for 25 to 35 minutes."]',
                                   '["3 eggs", "1 tsp. soda", "1 c. coconut", "2 c. apples, chopped", "1 1/4 c. oil", "1/2 tsp. cinnamon", "2 c. sugar", "1 c. pecans", "3 c. flour", "1/2 tsp. salt"]',
                                   ARRAY ['eggs', 'soda', 'coconut', 'apples', 'oil', 'cinnamon', 'sugar', 'pecans', 'flour', 'salt']);
select cooking_camel_schema.insert('Cheeseburger Pie',
                                   '["Brown meat and seasoning in skillet.", "Drain off fat.", "Add tomato paste; blend.", "Turn mixture out on crust.", "Top with cheese. Bake at 375\u00b0 for 10 to 15 minutes."]',
                                   '["1 lb. ground beef", "1 Tbsp. onions", "1 tsp. salt", "1/4 tsp. pepper", "3/4 tsp. Italian seasoning", "1 (6 oz.) can tomato paste", "1 pizza crust", "8 oz. shredded Mozzarella cheese"]',
                                   ARRAY ['ground beef', 'onions', 'salt', 'pepper', 'Italian seasoning', 'tomato paste', 'crust', 'Mozzarella cheese']);
select cooking_camel_schema.insert('Fried Cabbage',
                                   '["Chop or cut up in small pieces; let stand at least 1 hour. Put 3 tablespoons of oil in skillet and heat.", "Drain vegetables. Put in skillet.", "Add 1/2 cup water and cook 20 or 30 minutes."]',
                                   '["1 head cabbage", "1 onion", "1 bell pepper", "1 ripe tomato", "2 Tbsp. sugar", "1 tsp. salt", "1 tsp. pepper"]',
                                   ARRAY ['cabbage', 'onion', 'bell pepper', 'tomato', 'sugar', 'salt', 'pepper']);
select cooking_camel_schema.insert('Jello Salad(This Is Almost Like A Dessert, Yummy.)  ',
                                   '["Cook until dissolved the water, pineapple juice and marshmallows.", "Add lemon and orange jello, stirring until dissolved.", "Cool until almost set at room temperature.", "Add carrots, celery, cottage cheese, mayonnaise and chopped nuts. Fold into jello mix.", "Fold in Dream Whip or other whipped cream. Pour into mold and chill."]',
                                   '["1 (No. 2) can crushed pineapple, drained", "1 c. water", "pineapple juice", "12 large marshmallows", "1 pkg. lemon jello", "1 pkg. orange jello", "1 c. grated carrots", "1 c. diced celery", "1 lb. cottage cheese", "1/2 c. mayonnaise", "3/4 c. chopped nuts", "1 pkg. Dream Whip or other whipped cream"]',
                                   ARRAY ['pineapple', 'water', 'pineapple juice', 'marshmallows', 'lemon jello', 'orange jello', 'carrots', 'celery', 'cottage cheese', 'mayonnaise', 'nuts', 'Dream Whip']);
select cooking_camel_schema.insert('Wedding Cookies',
                                   '["Preheat oven to 300\u00b0. Line 2 cookie sheets with parchment paper or leave them ungreased. Cream the butter, sugar and vanilla until light and fluffy. Add the flour and mix on low speed until very well blended. Add the nuts and mix well until well blended. Measure out generously rounded teaspoonfuls of dough and roll them into balls with your hands. Place about 2-inches apart on the prepared cookie sheets. Bake the cookies until they begin to turn golden, about 30 minutes. To test for doneness, remove 1 from sheet and cut in half. There should be no doughy strip in the center. Roll the cookies in the powdered sugar while hot. Then cool on the cookie sheets. Serve after cookies have cooled."]',
                                   '["1 stick unsalted butter (room temperature)", "2 Tbsp. granulated sugar", "1 tsp. vanilla", "1 c. all-purpose flour, sifted", "1 c. finely chopped walnuts", "1 c. powdered sugar, sifted"]',
                                   ARRAY ['unsalted butter', 'sugar', 'vanilla', 'flour', 'walnuts', 'powdered sugar']);
select cooking_camel_schema.insert('Jezebel Sauce',
                                   '["Blend all ingredients.", "Serve over cream cheese. Serve with crackers."]',
                                   '["1 (18 oz.) jar pineapple preserves", "1 (18 oz.) jar apple jelly", "1 (5 oz.) jar horseradish", "1 1/4 oz. dry mustard", "1 Tbsp. coarse black pepper"]',
                                   ARRAY ['pineapple', 'apple jelly', 'horseradish', 'mustard', 'coarse black pepper']);
select cooking_camel_schema.insert('Banana Bread',
                                   '["Sift together the flour and soda.", "Mix all ingredients together and bake at 350\u00b0 for 45 minutes."]',
                                   '["1 c. sugar", "2 eggs", "2 c. flour", "1 tsp. soda", "vanilla to taste", "pinch of salt", "1/2 c. chopped nuts (optional)", "1/2 c. shortening", "3 bananas, mashed"]',
                                   ARRAY ['sugar', 'eggs', 'flour', 'soda', 'vanilla', 'salt', 'nuts', 'shortening', 'bananas']);
select cooking_camel_schema.insert('Mexicali Chicken And Cheese Bake',
                                   '["Heat oven to 350\u00b0.", "Grease 13 x 9-inch baking dish.", "In large bowl, combine chicken, 1 cup cheese, corn and soup; blend well. Spoon into prepared dish.", "Combine other ingredients in order listed.", "Mix until just moistened.", "Batter will be lumpy.", "Pour over chicken mixture.", "Bake 50 to 60 minutes.", "Sprinkle with cheese.", "Return to oven to melt cheese.", "Let stand 10 minutes before serving.", "Serves 8."]',
                                   '["3 c. cubed, cooked chicken", "8 oz. (2 c.) shredded Monterey Jack cheese", "12 oz. can whole kernel corn, drained", "10 3/4 oz. can condensed cream of chicken soup", "1 c. flour", "1/4 c. cornmeal", "1 3/4 tsp. baking powder", "chili powder or seasoned salt", "1 1/2 c. milk", "1/2 c. margarine, melted", "3 eggs, beaten", "1/4 c. chopped onion", "4 oz. can chopped green chillies", "2 oz. chopped pimento, drained"]',
                                   ARRAY ['chicken', 'shredded Monterey Jack cheese', 'whole kernel corn', 'condensed cream', 'flour', 'cornmeal', 'baking powder', 'chili powder', 'milk', 'margarine', 'eggs', 'onion', 'green chillies', 'pimento']);
select cooking_camel_schema.insert('Ripe Tomato Ketchup',
                                   '["Chop all ingredients.", "Add seasonings, sugar and vinegar. Cook 40 minutes.", "Can and seal."]',
                                   '["1 gal. chopped cabbage", "1 gal. tomatoes", "6 to 8 onions", "6 small bell peppers", "1 qt. vinegar", "1 hot pepper", "5 lb. sugar or to taste", "1 Tbsp. allspice", "1/2 tsp. cinnamon", "1/2 tsp. nutmeg", "1 Tbsp. salt"]',
                                   ARRAY ['cabbage', 'tomatoes', 'onions', 'bell peppers', 'vinegar', 'hot pepper', 'sugar', 'allspice', 'cinnamon', 'nutmeg', 'salt']);
select cooking_camel_schema.insert('Fresh Broccoli Salad',
                                   '["Wash and cut broccoli into bite size pieces.", "Combine salad dressing, vinegar and sugar; mix well.", "Pour dressing mixture over other ingredients and toss.", "Refrigerate 2 hours before serving."]',
                                   '["2 bunches fresh broccoli", "10 slices bacon, cooked and crumbled", "2/3 c. raisins", "1/2 c. onion, chopped", "1 c. salad dressing (Miracle Whip)", "1/2 c. sugar", "2 Tbsp. vinegar", "1/2 c. slivered almonds (optional)", "1/2 c. sharp cheese (optional)"]',
                                   ARRAY ['fresh broccoli', 'bacon', 'raisins', 'onion', 'salad dressing', 'sugar', 'vinegar', 'slivered almonds', 'sharp cheese']);
select cooking_camel_schema.insert('Lemon Chicken',
                                   '["Preheat oven to 400\u00b0.", "Cut up chicken and place in a pan. Melt butter and squeeze fresh lemon juice into butter.", "Baste chicken.", "Sprinkle with oregano and bake at 400\u00b0 for 1 hour."]',
                                   '["1 whole chicken, cut up", "3 large lemons", "1 stick butter", "oregano"]',
                                   ARRAY ['chicken', 'lemons', 'butter', 'oregano']);
select cooking_camel_schema.insert('Cherry Topsy-Turvy Pudding',
                                   '["Cream together butter and 1 cup sugar.", "Sift together flour, baking powder and salt.", "Add alternately with milk to creamed mixture.", "Pour into greased casserole dish.", "Combine cherries with remaining 1/4 cup sugar and 1/4 cup reserved cherry juice.", "Heat cherry mixture and pour over batter.", "Bake at 350\u00b0 for 35 to 40 minutes.", "Serves 6."]',
                                   '["2 Tbsp. butter", "1 1/4 c. sugar, divided", "1 c. flour", "1 tsp. baking powder", "1/8 tsp. salt", "3/4 c. milk", "1 1/2 c. canned tart cherries (reserve the juice)", "1/4 c. cherry juice"]',
                                   ARRAY ['butter', 'sugar', 'flour', 'baking powder', 'salt', 'milk', 'tart cherries', 'cherry juice']);
select cooking_camel_schema.insert('Strawberry Pan Pie',
                                   '["Mix sugar, water and cornstarch.", "Cook until thick and clear. Add red food coloring.", "Let cool.", "Put raw strawberries in glaze. Stir and pour in a baked crust."]',
                                   '["1 c. sugar", "3 level Tbsp. cornstarch", "1 (9-inch) pie crust, baked", "1 pt. raw strawberries", "1 c. water"]',
                                   ARRAY ['sugar', 'cornstarch', 'pie crust', 'raw strawberries', 'water']);
select cooking_camel_schema.insert('Cream Tacos',
                                   '["Fry hamburger with onion.", "Layer corn tortillas (cut in 1/4) in pan.", "Put 1 teaspoon hamburger on each piece, 1 teaspoon green chili on top of hamburger, then 1 teaspoon tomato sauce, top with grated cheese.", "Repeat layers until all ingredients are gone.", "Pour can of milk over all.", "Cover with foil.", "Bake in oven at 350\u00b0 for 30 to 35 minutes until milk evaporates."]',
                                   '["1 lb. hamburger", "onion", "1 doz. corn tortillas", "green chili", "2 small cans tomato sauce", "1 can evaporated milk", "Cheddar cheese, grated"]',
                                   ARRAY ['hamburger', 'onion', 'corn tortillas', 'green chili', 'tomato sauce', 'milk', 'Cheddar cheese']);
select cooking_camel_schema.insert('Scottish Shortbread',
                                   '["Cut butter into small pieces and set aside to warm to room temperature.", "Grease an 8 x 8-inch square (not glass) baking pan with butter and set aside.", "Sift together dry ingredients in mixing bowl.", "Add the butter pieces and rub in with fingers. Knead mixture gently to make a soft dough.", "Press into the prepared pan and flatten, using fingertips.", "Prick all over with a fork and bake in a preheated 325\u00b0 oven for 30 to 35 minutes or until a pale golden color.", "Cool slightly, sprinkle with a little granulated sugar and cut into 1 x 2-inch fingers.", "Cool on a wire rack and store in an airtight container."]',
                                   '["1/2 c. (1 stick) unsalted butter", "2 c. all-purpose flour", "1/4 c. sugar", "pinch of salt"]',
                                   ARRAY ['butter', 'flour', 'sugar', 'salt']);
select cooking_camel_schema.insert('Slaw',
                                   '["To make dressing mix together sugar, salt, pepper, celery seed, mustard and vinegar.", "Add mayonnaise, slowly, stirring well. Refrigerate dressing until ready to make slaw.", "Cut garlic in half, rub salad bowl with cut side of garlic clove.", "Add cut cabbage.", "Pour desired amount of dressing over cabbage and mix well.", "Chill."]',
                                   '["1/3 c. sugar", "3/4 tsp. salt", "3/4 tsp. pepper", "1 Tbsp. celery seed", "1 Tbsp. prepared mustard", "1/4 c. apple cider vinegar", "1 c. mayonnaise", "1 clove garlic", "cabbage"]',
                                   ARRAY ['sugar', 'salt', 'pepper', 'celery', 'mustard', 'apple cider vinegar', 'mayonnaise', 'clove garlic', 'cabbage']);
select cooking_camel_schema.insert('Hot Cheese Balls',
                                   '["Have cheese and oleo at room temperature.", "Mix well together with your hands, then add other ingredients.", "Roll in 1-inch balls. Bake at 400\u00b0 for 15 to 20 minutes on ungreased cookie sheet."]',
                                   '["1/2 lb. Cheddar cheese, shredded", "1 stick oleo", "1 c. flour", "1/4 tsp. paprika", "1/4 tsp. salt", "dash of cayenne pepper (optional)"]',
                                   ARRAY ['Cheddar cheese', 'oleo', 'flour', 'paprika', 'salt', 'cayenne pepper']);
select cooking_camel_schema.insert('Pizza Cups',
                                   '["Brown ground beef and onion.", "Drain.", "Stir in tomato sauce and seasonings.", "Cook 5 minutes.", "Place biscuits in greased muffin tins, pressing to cover bottom and sides.", "Spoon meat mixture into biscuits.", "Top with cheese.", "Bake at 400\u00b0 for 12 minutes or until brown.", "Makes 20 pizza cups."]',
                                   '["1 lb. ground beef", "1/4 c. minced onion", "1/2 tsp. salt (optional)", "8 oz. tomato sauce", "1 tsp. Italian seasoning", "2 cans refrigerated biscuits (10 count)", "1/2 to 3/4 c. grated cheese"]',
                                   ARRAY ['ground beef', 'onion', 'salt', 'tomato sauce', 'Italian seasoning', 'grated cheese']);
select cooking_camel_schema.insert('All-American Apple Pie',
                                   '["If apples lack tartness, sprinkle with the 1 tablespoon lemon juice.", "In mixing bowl, combine sugar, flour, cinnamon and nutmeg (for a very juicy pie, omit the flour).", "Add sugar mixture to the sliced apples; toss to mix.", "Fill pastry-lined pie plate with apple mixture; dot with butter or margarine.", "Cut slits in top crust for escape of steam; place pastry atop filling.", "Seal and flute edge.", "Sprinkle some sugar atop, if desired."]',
                                   '["pastry for double pie crust", "6 c. thinly sliced cooking apples", "1 Tbsp. lemon juice (optional)", "1 c. sugar", "2 Tbsp. all-purpose flour", "1 tsp. ground cinnamon", "dash of ground nutmeg", "1 Tbsp. butter or margarine"]',
                                   ARRAY ['pastry', 'cooking apples', 'lemon juice', 'sugar', 'flour', 'ground cinnamon', 'ground nutmeg', 'butter']);
select cooking_camel_schema.insert('Strawberry Cake With Icing',
                                   '["Mix all ingredients well with electric mixer.", "Bake in layers or in long pan until done."]',
                                   '["1 box Duncan Hines strawberry supreme cake mix", "juice from 1 box frozen strawberries", "4 eggs", "1 c. Crisco", "1/2 c. water", "1 (3 oz.) box strawberry jello"]',
                                   ARRAY ['Duncan', 'frozen strawberries', 'eggs', 'Crisco', 'water', 'strawberry jello']);
select cooking_camel_schema.insert('Swedish Meat Balls',
                                   '["Combine all ingredients except jelly and sauce.", "Mix well and make balls.", "Brown in skillet.", "Combine jelly and chili sauce and mix well.", "Pour sauce over meat balls and bake in a 350\u00b0 oven for 45 minutes or place in large skillet on top of stove and simmer for 20 minutes."]',
                                   '["1 1/2 lb. ground beef", "1 box croutons (garlic and onion)", "1/4 c. chopped onion", "2 eggs", "salt and pepper to taste", "1 (10 oz.) jar grape jelly", "1 (10 oz.) bottle chili sauce"]',
                                   ARRAY ['ground beef', 'croutons', 'onion', 'eggs', 'salt', 'grape jelly', 'chili sauce']);
select cooking_camel_schema.insert('Calf Liver Braised In Wine',
                                   '["Coat liver in mixture of flour, salt and pepper.", "Set aside. Saute onion in butter until tender.", "Add liver and brown lightly on both sides.", "Dissolve bouillon in boiling water.", "Add mushrooms, bouillon, wine and basil.", "Cover and simmer 15", "minutes or until liver is tender.", "Serves 4."]',
                                   '["1 lb. calf liver, thinly sliced, cut in serving pieces", "1/4 c. flour", "1/2 tsp. salt", "1/8 tsp. pepper", "1/2 c. onion, chopped", "1/4 tsp. basil", "3 Tbsp. butter or margarine", "1 c. mushrooms, sliced", "1 cube beef bouillon", "1/2 c. water (boiling)", "1/2 c. dry red wine"]',
                                   ARRAY ['flour', 'salt', 'pepper', 'onion', 'basil', 'butter', 'mushrooms', 'beef bouillon', 'water', 'red wine']);
select cooking_camel_schema.insert('Sour Cream Pound Cake',
                                   '["Cream", "together", "sugar\tand oleo.", "Blend in sour cream. Add 3 eggs;", "blend.", "Add remaining 2 eggs and blend.", "Combine dry ingredients.", "Stir vanilla into milk.", "Add dry ingredients and milk", "alternately", "to", "creamed mixture.", "Blend after each addition (do not beat as it would incorporate too much air and lighten texture)."]',
                                   '["1 c. oleo", "1 c. sour cream", "3 c. sugar", "5 eggs", "3 c. plain flour", "1/2 tsp. baking powder", "1/4 tsp. baking soda", "1/4 tsp. salt", "1/2 c. milk", "2 tsp. vanilla"]',
                                   ARRAY ['oleo', 'sour cream', 'sugar', 'eggs', 'flour', 'baking powder', 'baking soda', 'salt', 'milk', 'vanilla']);
select cooking_camel_schema.insert('Baked Beans',
                                   '["Combine all ingredients well in a casserole dish.", "Bake for 1 hour at 325\u00b0."]',
                                   '["4 (15 oz.) cans Great Northern white beans", "3/4 lb. bacon, cooked and cut in pieces", "3/4 to 1 c. ketchup", "1 c. white sugar"]',
                                   ARRAY ['cans Great Northern white beans', 'bacon', 'ketchup', 'white sugar']);
select cooking_camel_schema.insert('Vanilla Ice Cream',
                                   '["Combine sugar, eggs, evaporated milk and vanilla in large mixing bowl.", "Add enough milk to fill freezer 3/4 full."]',
                                   '["6 eggs", "1 1/2 c. sugar", "1 can evaporated milk", "1 Tbsp. milk", "milk"]',
                                   ARRAY ['eggs', 'sugar', 'milk', 'milk', 'milk']);
select cooking_camel_schema.insert('Sparkle Cutout Cookies',
                                   '["Combine softened cream cheese, margarine, sugar and vanilla until well blended.", "Add flour and salt.", "Mix well.", "Chill.", "On a lightly floured surface, roll dough to 1/4-inch thickness.", "Cut with assorted cookie cutters.", "Place on ungreased cookie sheet. Decorate with colored sugar or icing.", "Bake at 375\u00b0 for 8 to 10 minutes, just until edges start to brown lightly."]',
                                   '["1 (8 oz.) cream cheese", "1 c. margarine", "2/3 c. sugar", "1/2 tsp. vanilla", "2 1/2 c. flour", "dash of salt"]',
                                   ARRAY ['cream cheese', 'margarine', 'sugar', 'vanilla', 'flour', 'salt']);
select cooking_camel_schema.insert('Taco Soup',
                                   '["Mix and put in crock-pot.", "Cook all day.", "If cooked on range top, simmer 2 to 3 hours."]',
                                   '["2 lb. hamburger meat, browned", "1 medium chopped onion", "1 pkg. (dry) Hidden Valley Ranch dressing mix", "1 pkg. taco seasoning mix", "1 can whole kernel corn", "1 can red kidney beans", "1 can pinto beans", "1 small can chopped chilies", "3 cans stewed tomatoes"]',
                                   ARRAY ['hamburger meat', 'onion', 'taco seasoning mix', 'whole kernel corn', 'red kidney beans', 'pinto beans', 'chilies', 'tomatoes']);
select cooking_camel_schema.insert('Fruit Cocktail Cake',
                                   '["Mix all at one time, except brown sugar and pecans.", "Beat 3 minutes.", "Pour into 9 x 13 greased pan.", "Sprinkle with brown sugar and pecans.", "Bake at 350\u00b0 for 45 minutes."]',
                                   '["1 (No. 303) can fruit cocktail (juice also)", "1 1/2 c. sugar", "2 eggs", "1 tsp. vanilla", "2 tsp. soda", "1 tsp. cinnamon", "2 c. flour", "1/2 c. brown sugar", "1 c. pecans, chopped"]',
                                   ARRAY ['fruit cocktail', 'sugar', 'eggs', 'vanilla', 'soda', 'cinnamon', 'flour', 'brown sugar', 'pecans']);
select cooking_camel_schema.insert('Fa-La-La-La-Las',
                                   '["Heat oven to 400\u00b0.", "Cream butter flavor Crisco and sugar in large bowl at medium speed of electric mixer until well blended. Beat in egg, salt, vanilla and almond extract.", "Stir in flour. Place dough in cookie press.", "Press into desired shapes 2 inches apart on cooled, ungreased baking sheet.", "Bake at 400\u00b0 for 5 to 7 minutes or until set, but not brown.", "Cool on baking sheet one minute.", "Remove to cooling rack.", "Makes 4 to 4 1/2 dozen cookies."]',
                                   '["1 c. butter flavor Crisco", "1/2 c. sugar", "1 egg", "3/4 tsp. salt", "3/4 tsp. vanilla", "1/2 tsp. almond extract", "2 1/4 c. all-purpose flour"]',
                                   ARRAY ['butter', 'sugar', 'egg', 'salt', 'vanilla', 'almond extract', 'all-purpose']);
select cooking_camel_schema.insert('Orange-Coconut Pie',
                                   '["Cream butter; gradually add sugar, beating well at medium speed of an electric mixer.", "Add eggs and beat until blended.", "Stir in orange juice, lemon extract, salt and coconut, mixing well.", "Pour into pie crust.", "Bake at 350\u00b0 for 45 to 50 minutes or until a knife inserted in center comes out clean."]',
                                   '["1/4 c. butter or margarine, softened", "1 c. sugar", "3 eggs, beaten", "1/2 c. orange juice", "1 tsp. lemon extract", "dash of salt", "1 c. flaked coconut", "1 (9-inch) pie crust, unbaked"]',
                                   ARRAY ['butter', 'sugar', 'eggs', 'orange juice', 'lemon extract', 'salt', 'flaked coconut', 'pie crust']);
select cooking_camel_schema.insert('Sour Cream Pound Cake',
                                   '["Preheat oven to 325\u00b0.", "Cream butter and sugar together.", "Beat well.", "Continue beating, add eggs one at a time.", "Add flour and baking soda.", "Beat well.", "Add sour cream and vanilla.", "Pour into greased and floured tube pan.", "Bake one hour or maybe a little longer."]',
                                   '["2 sticks butter (real)", "3 c. sugar", "3 c. flour", "6 eggs", "1 tsp. vanilla", "1/4 tsp. baking soda", "1/2 pt. sour cream"]',
                                   ARRAY ['butter', 'sugar', 'flour', 'eggs', 'vanilla', 'baking soda', 'sour cream']);
select cooking_camel_schema.insert('Company Chicken',
                                   '["Mix first 4 ingredients together.", "Place chicken on top.", "Put a pat of butter on each piece of chicken; season to taste.", "Bake for 1 hour at 375\u00b0."]',
                                   '["1 c. instant rice", "1 can cream of mushroom soup", "1 can cream of chicken soup", "1 can cream of celery soup", "4 chicken breasts"]',
                                   ARRAY ['instant rice', 'cream of mushroom soup', 'cream of chicken soup', 'cream of celery soup', 'chicken breasts']);
select cooking_camel_schema.insert('Minestrone Soup',
                                   '["In a 2-quart saucepan, saute carrots, celery, onions", "and garlic in margarine.", "Add remaining ingredients except cheese. Simmer, covered, for 15 minutes.", "Top each serving with Parmesan cheese. Serves six."]',
                                   '["1 c. thinly sliced carrots", "1 c. sliced celery", "1/2 c. chopped onions", "1 clove garlic, minced", "2 Tbsp. margarine", "2 cans (15 oz.) Chef Boyardee Beefogetti", "1 can chickpeas, drained", "2 c. water", "2 beef bouillon cubes", "1/2 tsp. salt", "1/4 tsp. crushed basil", "1/4 tsp. pepper", "Parmesan cheese"]',
                                   ARRAY ['carrots', 'celery', 'onions', 'clove garlic', 'margarine', 'Boyardee', 'chickpeas', 'water', 'salt', 'basil', 'pepper', 'Parmesan cheese']);
select cooking_camel_schema.insert('Cherry Topped Cheesecake',
                                   '["Preheat oven to 300\u00b0.", "Reserve 1 cup of dry cake mix.", "In large mixing bowl, combine remaining cake mix, 1 of the eggs and oil (mixture will be crumbly).", "Press mixture in bottom of 13 x 9-inch pan for crust.", "Press up sides."]',
                                   '["1 pkg. yellow cake mix", "2 Tbsp. oil", "2 (8 oz.) pkg. cream cheese", "1/2 c. sugar", "4 eggs", "1 1/2 c. milk", "3 Tbsp. lemon juice", "3 Tbsp. vanilla", "1 can cherry pie filling"]',
                                   ARRAY ['yellow cake mix', 'oil', 'cream cheese', 'sugar', 'eggs', 'milk', 'lemon juice', 'vanilla', 'cherry pie filling']);
select cooking_camel_schema.insert('Sweet N Sour Sauce',
                                   '["Blend all ingredients together well.", "Use for bean salad or cucumbers."]',
                                   '["1/2 c. vinegar", "1/2 c. sugar", "1/3 c. oil"]',
                                   ARRAY ['vinegar', 'sugar', 'oil']);
select cooking_camel_schema.insert('Easy Taco Dip',
                                   '["In a glass pie pan, layer all three ingredients, placing cream cheese on the bottom of the pan, chili in the middle, shredded Cheddar cheese on top.", "Place in microwave on High for about 5 to 6 minutes.", "Use nacho chips to dip with.", "Great for parties and snacks."]',
                                   '["1 large pkg. cream cheese", "1 can Hormel chili", "2 c. shredded Cheddar cheese"]',
                                   ARRAY ['cream cheese', 'Hormel chili', 'Cheddar cheese']);
select cooking_camel_schema.insert('Monkey Bread',
                                   '["Separate rolls.", "Dip each into margarine, then into sugar and cinnamon mixture.", "Stack unevenly in casserole or ring pan.", "Bake at 425\u00b0 for 20 to 25 minutes.", "Turn out onto plate.", "Drizzle powdered sugar icing over top, if desired."]',
                                   '["2 pkg. refrigerator rolls", "1/2 c. melted margarine or butter", "3/4 c. sugar", "1 tsp. cinnamon"]',
                                   ARRAY ['refrigerator rolls', 'margarine', 'sugar', 'cinnamon']);
select cooking_camel_schema.insert('Coconut Cream Pie Or Lemon Meringue Pie',
                                   '["Note:", "For lemon pie, use 1 1/2 cups milk and 1/2 cup ReaLemon, no flavoring."]',
                                   '["3 eggs, separated", "4 Tbsp. cornstarch", "2 c. milk", "2 Tbsp. butter", "1 1/2 c. sugar", "1 Tbsp. coconut flavoring", "1 unbaked pie shell"]',
                                   ARRAY ['eggs', 'cornstarch', 'milk', 'butter', 'sugar', 'coconut flavoring', 'shell']);
select cooking_camel_schema.insert('Death By Chocolate',
                                   '["Bake cake mix according to instructions on box. Cool completely; break into small pieces. Mix together Jell-O, Dream Whip and milk; beat well. Refrigerate 1 hour."]',
                                   '["1 chocolate cake mix", "2 (8 oz.) containers Cool Whip", "2 envelopes Dream Whip", "2 pkg. chocolate Jell-O instant pudding", "3 c. cold milk", "4 Heath bars (optional)"]',
                                   ARRAY ['chocolate cake mix', 'containers', 'Dream Whip', 'chocolate', 'cold milk']);
select cooking_camel_schema.insert('Corn Meal Muffins',
                                   '["Sift flour.", "Measure and sift with baking soda, salt and baking powder.", "Mix with corn meal.", "Combine bacon fat, sugar and eggs.", "Add sour milk.", "Combine with dry ingredients.", "Beat only until smooth.", "Fill well-oiled muffin pan 2/3 full.", "Bake in hot oven (435\u00b0) for 15 to 20 minutes."]',
                                   '["1 c. corn meal", "2 Tbsp. brown sugar", "3/4 tsp. baking soda", "2 eggs, well beaten", "1 1/2 c. sour milk", "1 c. flour", "1 tsp. salt", "1 tsp. baking powder", "1/4 c. melted bacon fat"]',
                                   ARRAY ['corn meal', 'brown sugar', 'baking soda', 'eggs', 'sour milk', 'flour', 'salt', 'baking powder', 'bacon fat']);
select cooking_camel_schema.insert('Hot Taco Rice',
                                   '["Brown meat and onion in skillet; drain.", "Add salsa and tomato sauce with bouillon cube.", "Bring to boil, then simmer, covered, for 5 minutes."]',
                                   '["1 lb. ground beef", "1 onion, chopped", "1 1/2 c. salsa sauce", "1 chicken bouillon cube", "1 can tomato sauce", "1 1/2 c. Minute rice"]',
                                   ARRAY ['ground beef', 'onion', 'salsa sauce', 'chicken', 'tomato sauce', 'rice']);
select cooking_camel_schema.insert('Moist DevilS Food Cake',
                                   '["Blend all ingredients together with electric mixer on medium speed for 3 minutes.", "Bake in greased and floured tube pan for 40 minutes at 350\u00b0."]',
                                   '["1 devils food cake mix", "1 can cherry pie filling", "1/4 c. oil", "3 eggs"]',
                                   ARRAY ['cake mix', 'cherry pie filling', 'oil', 'eggs']);
select cooking_camel_schema.insert('Peanut Butter Twinkies',
                                   '["In a saucepan, bring sugar and syrup to a full boil.", "Remove from heat.", "Add peanut butter, oleo and vanilla.", "Add enough cornflakes to be able to press into well-buttered 13 x 9-inch pan. Cut into squares while still warm."]',
                                   '["1 c. sugar", "1 c. light Karo syrup", "1 c. peanut butter", "1/4 stick oleo", "1 Tbsp. vanilla", "6 to 8 c. cornflakes"]',
                                   ARRAY ['sugar', 'light Karo syrup', 'peanut butter', 'oleo', 'vanilla', 'cornflakes']);
select cooking_camel_schema.insert('Low-Calorie Pumpkin Pie',
                                   '["Heat oven to 350\u00b0.", "Lightly grease or spray a 9-inch pie pan with vegetable spray.", "Place all ingredients in blender, food processor or mixing bowl.", "Blend 1 minute or beat 2 minutes with mixer.", "Pour into pie pan.", "Bake for 50 minutes or until center is puffed up.", "Makes 8 servings (112 calories)."]',
                                   '["1 (16 oz.) can solid pack pumpkin", "1 (13 oz.) can evaporated skim milk", "1 egg", "2 egg whites", "1/2 c. biscuit mix (Bisquick type)", "2 Tbsp. sugar", "6 packets sugar substitute", "2 tsp. pumpkin pie spice", "2 tsp. vanilla"]',
                                   ARRAY ['solid pack pumpkin', 'milk', 'egg', 'egg whites', 'biscuit mix', 'sugar', 'packets sugar substitute', 'pumpkin pie spice', 'vanilla']);
select cooking_camel_schema.insert('Zucchini Squares',
                                   '["Mix all together and bake at 350\u00b0 in a greased 9 x 13-inch pan for about 1/2 hour.", "Top will turn light brown."]',
                                   '["2 c. zucchini, shredded", "1/2 c. onion, chopped", "1 clove garlic", "1/2 c. grated Parmesan", "1/2 c. oil", "2 Tbsp. dried parsley", "1/2 tsp. salt", "1/2 tsp. seasoned salt", "1/2 tsp. oregano", "2 eggs, slightly beaten"]',
                                   ARRAY ['zucchini', 'onion', 'clove garlic', 'Parmesan', 'oil', 'parsley', 'salt', 'salt', 'oregano', 'eggs']);
select cooking_camel_schema.insert('Pound Cake',
                                   '["Cream butter, Crisco and sugar.", "Add eggs, one at a time.", "Add flour, a cup at a time.", "Add milk, a third at a time, then mix good.", "Beat 3 minutes.", "Put in a tube pan (greased and floured). Place in cold oven.", "Turn to 350\u00b0 and bake for 1 hour and 15 minutes."]',
                                   '["1 stick butter", "1 c. Crisco", "3 c. sugar", "6 eggs", "3 c. plain flour", "1/2 tsp. baking powder", "1 c. sweet milk", "1 tsp. vanilla"]',
                                   ARRAY ['butter', 'Crisco', 'sugar', 'eggs', 'flour', 'baking powder', 'sweet milk', 'vanilla']);
select cooking_camel_schema.insert('Chocolate Eclair Dessert',
                                   '["Line a buttered 9 x 13-inch serving dish with half the graham crackers.", "Beat pudding mix and 3 1/2 cups milk in mixer bowl for 2 minutes.", "Fold in whipped topping.", "Layer half the pudding mixture, remaining graham crackers and remaining pudding mixture in prepared dish.", "Chill for 2 hours.", "Combine Choco-bake, corn syrup, vanilla and margarine in bowl; beat well.", "Add confectioners sugar and 3 tablespoons milk alternately, beating well after each addition.", "Spread over dessert."]',
                                   '["20 (about) graham crackers", "2 (4 oz.) pkg. vanilla instant pudding mix", "3 1/2 c. milk", "8 oz. whipped topping", "2 pkg. Choco-bake", "2 tsp. light corn syrup", "2 tsp. vanilla", "3 Tbsp. margarine, softened", "1 1/2 c. confectioners sugar", "3 Tbsp. milk"]',
                                   ARRAY ['graham crackers', 'vanilla instant pudding mix', 'milk', 'Choco-bake', 'light corn syrup', 'vanilla', 'margarine', 'confectioners sugar', 'milk']);
select cooking_camel_schema.insert('Butternut Cookies',
                                   '["Cream the butter, sugar and vanilla until fluffy. Add flour and salt.", "Blend well. Add nuts.", "Mix well and shape into 1-inch balls. Bake at 325\u00b0 for 20 minutes. Do not brown.", "Cool and roll into confectioners sugar."]',
                                   '["2 c. butter", "1 c. sugar", "4 tsp. vanilla", "4 c. flour", "1 tsp. salt", "4 c. finely chopped walnuts", "confectioners sugar"]',
                                   ARRAY ['butter', 'sugar', 'vanilla', 'flour', 'salt', 'walnuts', 'confectioners sugar']);
select cooking_camel_schema.insert('Hattie CofferS Kool-Aid Punch',
                                   '["Make a syrup of the 1 cup of water and 2 cups of sugar. Cook until sugar is dissolved.", "Add the remaining ingredients. Makes about 30 cups."]',
                                   '["1 c. water", "2 c. sugar", "1 qt. ginger ale", "1 pkg. Kool-Aid (any flavor)", "1/2 c. lemon juice", "2 c. pineapple juice", "10 c. water"]',
                                   ARRAY ['water', 'sugar', 'ginger ale', 'lemon juice', 'pineapple juice', 'water']);
select cooking_camel_schema.insert('Scalloped Corn',
                                   '["Heat oven to 350\u00b0. Saute onion in butter until golden. Blend in flour and seasonings; cook until bubbly. Remove from heat. Add milk gradually, stirring as you add. Bring to a boil and cook 1 minute; stir constantly. Remove from heat and add corn and egg. Place in baking dish. Top with breadcrumbs. Bake for 30 minutes."]',
                                   '["1/2 c. onions, chopped", "2 Tbsp. butter", "2 Tbsp. flour", "1 tsp. salt", "1/2 tsp. paprika", "dash of black pepper", "3/4 c. milk", "1 can whole kernel corn", "1 egg, slightly beaten", "breadcrumbs"]',
                                   ARRAY ['onions', 'butter', 'flour', 'salt', 'paprika', 'black pepper', 'milk', 'whole kernel corn', 'egg', 'breadcrumbs']);
select cooking_camel_schema.insert('BeckyS Punch',
                                   '["Mix the Kool-Aid, Jell-O, and water together.", "Add sugar, lemonade, and pineapple juice.", "Stir well and freeze.", "Thaw one hour before serving and add 2 liters of soda."]',
                                   '["1 pkg. black cherry or cherry Kool-Aid", "1 small box Jell-O (same flavor)", "2 qts. warm water", "1 can pineapple juice", "1 can frozen lemonade", "1 cup sugar", "2 liters 7-up"]',
                                   ARRAY ['black cherry', 'water', 'pineapple juice', 'frozen lemonade', 'sugar']);
select cooking_camel_schema.insert('Chicken Saltimbocca',
                                   '["Place chicken, boned side up, between two pieces clear plastic wrap.", "Working out from the center, pound each lightly with meat mallet to 5 1/2 x 5 1/2 inches.", "Remove wrap.", "Place a ham slice and a cheese slice on each cutlet, cutting to fit within 1/4 inch of edges.", "Top with some tomato; sprinkle lightly with sage.", "Fold in sides; roll up jelly roll fashion, pressing to seal well. Combine crumbs, Parmesan and parsley.", "Dip chicken in butter, then roll in crumbs.", "Bake in shallow baking pan at 350\u00b0 for 40 to 45 minutes.", "Remove to platter.", "Blend mixture remaining in pan until smooth; serve over chicken.", "Serves 6."]',
                                   '["3 whole large chicken breasts, skinned, boned and halved lengthwise", "6 thin slices boiled ham", "6 slices process Swiss cheese", "1 medium tomato, peeled, seeded and chopped", "crushed dried sage", "1/3 c. fine dry bread crumbs", "2 Tbsp. grated Parmesan cheese", "2 Tbsp. snipped parsley", "1/4 c. butter, melted"]',
                                   ARRAY ['chicken breasts', 'thin', 'Swiss cheese', 'tomato', 'sage', 'bread crumbs', 'Parmesan cheese', 'parsley', 'butter']);
select cooking_camel_schema.insert('Toll House Cookies',
                                   '["Mix together", "shortening,", "brown sugar and white sugar. Sift and add", "flour,", "soda, eggs, hot water, vanilla and salt. Add oatmeal,", "nuts,", "chocolate\tchips", "or", "butterscotch chips. Drop by teaspoonful on", "cookie", "sheet.", "Bake at 350\u00b0 for 10 to 15 minutes."]',
                                   '["1 c. shortening", "3/4 c. brown sugar", "3/4 c. white sugar", "1 1/2 c. sifted flour", "1 tsp. soda", "2 eggs, beaten", "1 tsp. hot water", "1 tsp. vanilla", "1 tsp. salt", "2 c. oatmeal", "1 c. chopped nuts", "1 pkg. Toll House chocolate chips or butterscotch chips"]',
                                   ARRAY ['shortening', 'brown sugar', 'white sugar', 'flour', 'soda', 'eggs', 'water', 'vanilla', 'salt', 'oatmeal', 'nuts', 'chocolate chips']);
select cooking_camel_schema.insert('Chicken Tortilla Casserole',
                                   '["Combine soups, sour cream, picante sauce and onion. Heat to almost boiling. Grease 9 x 9-inch baking pan. Break tortillas into pieces. Line pan with half of the tortillas. Spread half of chicken on tortillas and pour half of soup mixture over top. Repeat layers with remaining ingredients and top with cheese. Bake in 350\u00b0 oven for 30 to 40 minutes."]',
                                   '["12 tortillas", "1 chicken, cooked and boned", "1 can cream of chicken soup", "1 can cream of mushroom soup", "1 c. sour cream", "1 c. picante sauce", "onion to taste", "Cheddar cheese"]',
                                   ARRAY ['tortillas', 'chicken', 'cream of chicken soup', 'cream of mushroom soup', 'sour cream', 'picante sauce', 'onion', 'Cheddar cheese']);
select cooking_camel_schema.insert('Chop Suey',
                                   '["Brown meat and cook until tender, 2 to 2 1/2 hours.", "Add mushroom and onions.", "Cook until onions are done.", "Add 6 to 8 cups water, soy sauce and vegetables.", "Thicken with cornstarch in a mixture of 1/2 water and 1/2 soy sauce.", "Serve over rice or noodles."]',
                                   '["1 to 1 1/2 lb. stew meat", "1 can mushrooms", "1 large can chop suey vegetables", "1 medium onion", "1 c. soy sauce"]',
                                   ARRAY ['stew meat', 'mushrooms', 'chop suey vegetables', 'onion', 'soy sauce']);
select cooking_camel_schema.insert('Vegetable Pizza',
                                   '["Press crescent rolls flat on baking sheet. Do not separate rolls. Bake according to package directions until golden brown. In a medium bowl, combine cream cheese, mayonnaise and dressing mix. Spread mixture on cooled crescent rolls.", "Top with finely chopped vegetables, spreading evenly to cover rolls. Chill until firm. (Best made a day ahead.) Serves 12 to 15."]',
                                   '["1 (8 oz.) pkg. crescent rolls", "2 (8 oz. each) pkg. cream cheese, softened", "1 c. mayonnaise", "1/2 (10 oz.) pkg. Hidden Valley Ranch mix", "4 c. finely chopped raw vegetables (cauliflower, broccoli, carrots, green onions, etc.)"]',
                                   ARRAY ['crescent rolls', 'cream cheese', 'mayonnaise', 'vegetables']);
select cooking_camel_schema.insert('Log Cabin Toast',
                                   '["Mix sugar and cinnamon in custard cup.", "Toast bread.", "Spread with soft margarine.", "Sprinkle with sugar-cinnamon mixture.", "Cut each slice of toast into 4 strips.", "Put them together on plate like stacked logs to make the wall of a log cabin.", "Start from the top and eat all the logs."]',
                                   '["1/4 c. sugar", "2 tsp. cinnamon", "2 slices white or whole wheat bread", "soft margarine or butter"]',
                                   ARRAY ['sugar', 'cinnamon', 'white', 'margarine']);
select cooking_camel_schema.insert('Yum Yum Salad', '["Mix together and let stand overnight in refrigerator."]',
                                   '["1 can cherry pie filling", "1 large can drained, crushed pineapple", "1 can Borden milk", "3/4 c. chopped pecans", "1 (8 oz.) Cool Whip"]',
                                   ARRAY ['cherry pie filling', 'pineapple', 'Borden milk', 'pecans']);
select cooking_camel_schema.insert('My Caramel Rolls',
                                   '["Combine first four ingredients and beat with electric mixer until light and fluffy.", "Add remaining ingredients, stirring well. Let rise once.", "While it rises, prepare the caramel."]',
                                   '["3 pkg. yeast", "1/2 cup sugar", "2 cups warm water", "2 eggs", "3 Tbsp. oleo", "1 tsp. salt", "6-7 cups flour"]',
                                   ARRAY ['yeast', 'sugar', 'water', 'eggs', 'oleo', 'salt', 'flour']);
select cooking_camel_schema.insert('Spanish Hamburger #1',
                                   '["Fry hamburger half done.", "Cut onion, green pepper and celery in fine pieces and add.", "Let simmer 1/2 hour.", "Add salt and pepper, then add tomato soup. Simmer 2 hours.", "Keep steam in for best results."]',
                                   '["6 lb. hamburger", "salt and pepper", "1 medium white onion", "1/2 green pepper", "1 stalk celery", "1 (20 oz.) can tomato soup"]',
                                   ARRAY ['hamburger', 'salt', 'white onion', 'green pepper', 'celery', 'tomato soup']);
select cooking_camel_schema.insert('Turkey Vegetable Stir-Fry',
                                   '["Combine cornstarch, ginger, chicken broth and soy sauce in a 2-cup glass measure.", "Stir well.", "Microwave, uncovered, at High for 2 to 3 minutes or until thickened, stirring every 30 seconds. Set aside."]',
                                   '["1 Tbsp. cornstarch", "2 Tbsp. soy sauce", "1/4 tsp. ground ginger", "1 (10 1/2 oz.) can chicken broth", "1 carrot, cut into julienne strips", "2 Tbsp. vegetable oil", "2 c. sliced mushrooms", "4 green onions, minced", "1 stalk celery, diagonally sliced", "1 (6 oz.) pkg. snow peas, thawed", "2 c. coarsely chopped, cooked turkey breast", "2 c. brown rice, cooked", "2 Tbsp. slivered almonds, toasted"]',
                                   ARRAY ['cornstarch', 'soy sauce', 'ground ginger', 'chicken broth', 'carrot', 'vegetable oil', 'mushrooms', 'green onions', 'celery', 'snow peas', 'brown rice', 'slivered almonds']);
select cooking_camel_schema.insert('Mango With Tomatoes And Scallions Or Leeks',
                                   '["Slice mango, chunk tomatoes and slice leek; toss well.", "Whisk together the lemon juice and pulp, safflower oil and dry mustard; pour over mango mixture.", "Toss well.", "Serve chilled or at room temperature."]',
                                   '["1 large mango or 2 small", "2 medium tomatoes", "1 large leek or 2 scallions (green onions)", "lemon juice with pulp", "2 tsp. safflower oil", "pinch of dry mustard"]',
                                   ARRAY ['mango', 'tomatoes', 'scallions', 'lemon juice', 'safflower oil', 'mustard']);
select cooking_camel_schema.insert('Vegetable Pizza', '["Spread crescent rolls flat, bake and cut."]',
                                   '["2 cans crescent rolls", "2 large pkg. cream cheese, softened", "1/2 c. mayo (not Miracle Whip)", "1/2 c. Ranch dressing"]',
                                   ARRAY ['crescent rolls', 'cream cheese', 'mayo', 'dressing']);
select cooking_camel_schema.insert('Luau',
                                   '["Brown sausage.", "Remove sausage and cook the pepper, onions and celery in as little grease as possible.", "Boil 7 cups water.", "In boiling water, put soup, rice and almonds.", "Dont cook. Immediately stir all ingredients together.", "Cover and bake at 350\u00b0 for 40 to 45 minutes.", "Stir once or twice while baking.", "Serves 10 to 12."]',
                                   '["2 lb. pork sausage", "2 c. white Minute rice", "1 green pepper, chopped fine", "2 large onions, chopped fine", "1 bunch celery, chopped fine", "3 1/2 oz. chopped almonds", "2 dry packs Lipton noodle soup"]',
                                   ARRAY ['pork sausage', 'white Minute rice', 'green pepper', 'onions', 'celery', 'almonds', 'noodle soup']);
select cooking_camel_schema.insert('MaS Dill Pickles',
                                   '["Pack dills and cukes in jar.", "Boil brine and pour over hot and seal."]',
                                   '["7 c. water", "3 c. vinegar", "1/2 c. salt", "1/2 c. sugar"]',
                                   ARRAY ['water', 'vinegar', 'salt', 'sugar']);
select cooking_camel_schema.insert('Stir-Fried Gumbo',
                                   '["In a large skillet, melt butter and saute bell peppers, jalapeno, onion and carrot; cook until onion is clear.", "Add the stewed tomatoes; stir and cook about 5 minutes.", "Add 3/4 cup water, stirring until mixture boils.", "Add meat, stirring well."]',
                                   '["3 to 4 c. okra", "salt and pepper", "flour", "oil", "2 c. ground beef, chicken breast or ham", "3/4 c. green bell peppers, sliced", "1 small jalapeno pepper, chopped (optional)", "1 medium onion, sliced thin", "1 medium carrot or 3/4 c. thinly sliced", "3/4 stick butter", "1 can stewed tomatoes", "salt and pepper to taste"]',
                                   ARRAY ['okra', 'salt', 'flour', 'oil', 'ground beef', 'green bell peppers', 'jalapeno pepper', 'onion', 'carrot', 'butter', 'tomatoes', 'salt']);
select cooking_camel_schema.insert('No Bake Chocolate Cookies',
                                   '["Mix sugar, cocoa, milk and oleo in a saucepan.", "Bring to a boil and boil for 1 minute.", "Remove from stove and add remaining ingredients.", "Stir well.", "Drop by teaspoon on wax paper.", "Makes 4 to 5 dozen."]',
                                   '["2 c. sugar", "1/3 c. cocoa", "1/2 c. milk", "1 stick oleo", "1 tsp. vanilla", "1/2 c. peanut butter", "3 c. quick oats"]',
                                   ARRAY ['sugar', 'cocoa', 'milk', 'oleo', 'vanilla', 'peanut butter', 'oats']);
select cooking_camel_schema.insert('Carrot Cake',
                                   '["Place dry ingredients in a large bowl and mix thoroughly.", "Add rest of ingredients and mix well.", "Bake in well-greased and floured pans.", "Bake at 350\u00b0 for 30 minutes.", "Remove from pans and cool.", "Makes 2 (9-inch) or 3 (8-inch) layers."]',
                                   '["2 c. flour, sifted", "1 tsp. soda", "1 tsp. salt", "2 c. sugar", "1 tsp. cinnamon", "1 1/2 c. oil", "4 eggs", "2 c. grated carrots", "1 c. nuts"]',
                                   ARRAY ['flour', 'soda', 'salt', 'sugar', 'cinnamon', 'oil', 'eggs', 'carrots', 'nuts']);
select cooking_camel_schema.insert('No Fat Rice And Vegetable Dish',
                                   '["Spray skillet with vegetable spray and saute squash and onion until tender. Add mushrooms, tomatoes and seasonings. Cook 5 minutes. Mix with cooked rice."]',
                                   '["1 c. rice, cooked", "1/2 c. summer squash, sliced", "1/2 c. zucchini, sliced", "1/4 c. onions, chopped", "1/2 c. mushrooms, sliced", "1/2 c. fresh tomato, chopped", "1 tsp. garlic, chopped", "1/2 tsp. basil", "lemon pepper and salt to taste"]',
                                   ARRAY ['rice', 'summer squash', 'zucchini', 'onions', 'mushrooms', 'fresh tomato', 'garlic', 'basil', 'lemon pepper']);
select cooking_camel_schema.insert('Oyster Fritters',
                                   '["Sift flour, baking powder and baking soda.", "Beat eggs well. Add buttermilk and salt and beat again.", "Then mix in dry ingredients and oyster juice.", "Add oysters and stir to coat.", "Deep fry at 350\u00b0."]',
                                   '["2 c. flour", "2 tsp. baking powder", "1/2 tsp. baking soda", "3 eggs", "1/4 c. buttermilk", "salt to taste", "1 pt. oysters (reserve juice)"]',
                                   ARRAY ['flour', 'baking powder', 'baking soda', 'eggs', 'buttermilk', 'salt', 'oysters']);
select cooking_camel_schema.insert('Quick Coffee Cake(Double Recipe)  ',
                                   '["Mix all together.", "Spread in a 13 x 9-inch pan or two 8-inch pans.", "Sprinkle top thickly with sugar and cinnamon (is good with chopped nuts).", "Bake at 375\u00b0 for 15 to 21 minutes."]',
                                   '["2 c. flour", "6 tsp. baking powder", "1 tsp. cinnamon", "1 c. sugar", "1 tsp. salt", "2 beaten eggs", "1 c. milk", "1/2 c. melted oleo or butter"]',
                                   ARRAY ['flour', 'baking powder', 'cinnamon', 'sugar', 'salt', 'eggs', 'milk', 'oleo']);
select cooking_camel_schema.insert('Belly Buttons',
                                   '["Preheat oven to 400\u00b0.", "Follow directions for pie crust mix. Roll out pie crust on a flat, floured surface.", "Butter crust with butter or margarine.", "Sprinkle on brown sugar until it covers pie crust, then sprinkle cinnamon over brown sugar.", "Roll crust like a long, thin cinnamon roll.", "Cut sections 1-inch thick.", "Place sections on a buttered 13 x 9-inch casserole dish in an upright position so that the swirls are showing on both sides.", "Bake 15 minutes.", "Let cool 3 minutes and enjoy."]',
                                   '["1 box crust mix", "flour", "butter or margarine, softened", "brown sugar", "cinnamon"]',
                                   ARRAY ['crust', 'flour', 'butter', 'brown sugar', 'cinnamon']);
select cooking_camel_schema.insert('Tater Tot Casserole',
                                   '["Sear meat and onion until browned; add mixed vegetables and soup and mix well.", "Turn into buttered casserole dish and top with Tater Tots.", "Bake at 350\u00b0 for 45 minutes."]',
                                   '["1 lb. ground lean beef", "1 large onion, chopped", "1 can cream of mushroom soup", "1 can mixed vegetables (partially drained)", "Tater Tots as needed"]',
                                   ARRAY ['ground lean beef', 'onion', 'cream of mushroom soup', 'mixed vegetables', 'Tater']);
select cooking_camel_schema.insert('Cheesy Cornbread',
                                   '["Cook bacon in an 8-inch cast-iron skillet until crisp.", "Remove bacon, reserving 2 tablespoons drippings.", "Heat skillet with drippings in a 425\u00b0 oven for 5 minutes.", "Combine crumbled bacon and cornbread mix and remaining 4 ingredients, stirring just until dry ingredients are moistened.", "Remove skillet from oven.", "Pour mixture into skillet.", "Bake at 425\u00b0 for 30 to 35 minutes or until golden brown."]',
                                   '["4 slices bacon", "1 (16 oz.) pkg. cornbread mix", "2 eggs, beaten", "1 (15 oz.) can cream-style corn", "3/4 c. Kraft mayonnaise", "1 c. (4 oz.) shredded Swiss or Cheddar cheese"]',
                                   ARRAY ['bacon', 'cornbread mix', 'eggs', 'cream-style', 'mayonnaise', 'Swiss']);
select cooking_camel_schema.insert('Rice Crispy Chicken',
                                   '["Measure Rice Krispies cereal; crush to 2 cups.", "Place in shallow dish.", "Stir in paprika.", "Set aside."]',
                                   '["4 c. Rice Krispies", "1 tsp. paprika", "1 egg", "3/4 c. milk", "3/4 c. all-purpose flour", "1 1/2 tsp. salt", "1/4 tsp. pepper", "1 tsp. poultry seasoning", "3 Tbsp. margarine, melted", "3 lb. frying chicken pieces, cleaned and patted dry"]',
                                   ARRAY ['Rice Krispies', 'paprika', 'egg', 'milk', 'all-purpose', 'salt', 'pepper', 'poultry seasoning', 'margarine', 'chicken']);
select cooking_camel_schema.insert('No-Fat Added Oven Fried Chicken',
                                   '["Heat oven to 350\u00b0.", "Rinse chicken with cold running water; blot dry with paper towels.", "Coat nonstick baking sheet with vegetable cooking spray."]',
                                   '["4 skinless, boneless chicken breast halves (about 3 oz. each)", "vegetable cooking spray", "3 Tbsp. grated Parmesan cheese", "1/2 c. dry bread crumbs", "1 tsp. dried thyme", "1/4 tsp. garlic powder", "1/4 tsp. onion powder", "1/4 tsp. ground black pepper", "1/4 tsp. salt (optional)", "3/4 c. nonfat buttermilk"]',
                                   ARRAY ['skinless', 'vegetable cooking spray', 'Parmesan cheese', 'bread crumbs', 'thyme', 'garlic powder', 'onion powder', 'ground black pepper', 'salt', 'nonfat buttermilk']);
select cooking_camel_schema.insert('Sauerkraut Salad',
                                   '["Mix sauerkraut, green bell pepper, celery, pimento and onion together."]',
                                   '["1 qt. sauerkraut, drained", "1 c. green bell pepper, chopped", "1 c. celery, chopped", "1 (4 oz.) jar pimento", "1 medium onion, chopped", "1/2 c. vinegar", "1 1/2 c. sugar", "2 Tbsp. oil"]',
                                   ARRAY ['sauerkraut', 'green bell pepper', 'celery', 'pimento', 'onion', 'vinegar', 'sugar', 'oil']);
select cooking_camel_schema.insert('Sour Cream Meat Loaf',
                                   '["Combine all ingredients in large mixing bowl; blend well. Pack in a 9 x 5 x 3-inch loaf pan.", "Bake at 350\u00b0 for 1 1/2 to 1 3/4 hours.", "Serves 6."]',
                                   '["2 lb. ground lean beef", "1 1/2 c. grated raw carrot", "1/4 c. grated unpeeled apple", "1 1/2 c. grated raw potato", "1 onion, quartered and studded with 4 cloves", "6 slices fried bacon, crumbled", "2 beaten eggs", "2 1/4 tsp. salt", "1/2 tsp. pepper", "1/8 tsp. nutmeg", "1/8 tsp. dry mustard", "2 c. sour cream"]',
                                   ARRAY ['ground lean beef', 'carrot', 'apple', 'potato', 'onion', 'bacon', 'eggs', 'salt', 'pepper', 'nutmeg', 'dry mustard', 'sour cream']);
select cooking_camel_schema.insert('Stuffed Chicken Breast',
                                   '["Preheat oven to 375\u00b0.", "Cook stuffing as directed on package. Slice green pepper in small strips, then cut strips in half.", "Mix water and soup in a bowl."]',
                                   '["1 box Stove Top stuffing or homemade stuffing", "1 medium green pepper (optional)", "1/4 c. hot water", "1 can cream of mushroom soup", "8 boneless chicken breasts", "garlic salt", "pepper", "paprika"]',
                                   ARRAY ['Stove Top stuffing', 'green pepper', 'hot water', 'cream of mushroom soup', 'chicken breasts', 'garlic', 'pepper', 'paprika']);
select cooking_camel_schema.insert('MegS Power Peanut Butter Balls',
                                   '["Melt butter and pour over the graham cracker crumbs, confectioners sugar and peanut butter.", "Mix well and shape into bite size balls.", "Melt chocolate chips in double boiler with the paraffin.", "Dip the peanut butter balls in the chocolate and place on a greased cookie sheet.", "Mmmmmmm good!"]',
                                   '["1/2 c. graham cracker crumbs", "1 c. crunchy peanut butter", "1 box confectioners sugar", "2 sticks butter or margarine", "2 oz. paraffin", "chocolate chips"]',
                                   ARRAY ['graham cracker crumbs', 'crunchy peanut butter', 'confectioners sugar', 'butter', 'paraffin', 'chocolate chips']);
select cooking_camel_schema.insert('Indian Meat Loaf',
                                   '["Combine beef, pork and seasonings.", "Mix well.", "Add remaining ingredients.", "Place in a loaf pan.", "Bake at 350\u00b0 for 1 1/2 hours."]',
                                   '["1 lb. ground beef", "1/2 lb. ground pork", "1 1/2 tsp. salt", "1/4 tsp. pepper", "1/2 tsp. sage", "1 egg, beaten", "1/2 c. corn meal", "1/2 c. chopped onion", "1/4 c. diced green pepper", "1/2 c. cream-style corn", "1 1/4 c. canned tomatoes"]',
                                   ARRAY ['ground beef', 'ground pork', 'salt', 'pepper', 'sage', 'egg', 'corn meal', 'onion', 'green pepper', 'cream-style corn', 'tomatoes']);
select cooking_camel_schema.insert('Creamy Cheese Crab Dip',
                                   '["Mix the cream cheese, wine and garlic powder.", "Add the crabmeat.", "Bake in a casserole at 350\u00b0 for about 20 minutes. Serve with crackers or toast rounds."]',
                                   '["1 (8 oz.) and 1 (3 oz.) pkg. Philadelphia cream cheese", "1/2 c. white wine", "1 lb. crabmeat", "1/8 tsp. garlic powder"]',
                                   ARRAY ['Philadelphia cream cheese', 'white wine', 'crabmeat', 'garlic powder']);
select cooking_camel_schema.insert('Skillet Beef And Macaroni',
                                   '["In a skillet, cook beef and onion until the meat is browned and onion is tender.", "Drain.", "Stir in the remaining ingredients; bring to boil.", "Reduce heat; cover and simmer until macaroni is tender, about 20 minutes.", "Stir occasionally, adding additional water if needed.", "Yields 4 to 6 servings."]',
                                   '["1 to 1 1/2 lb. ground beef", "1/2 c. chopped onion", "2 cans (8 oz.) tomato sauce", "1 c. water", "1 (7 oz.) pkg. macaroni", "1/2 c. chopped green pepper", "2 Tbsp. Worcestershire sauce", "1 tsp. salt", "1/4 tsp. pepper", "1 1/2 Tbsp. chili powder"]',
                                   ARRAY ['ground beef', 'onion', 'tomato sauce', 'water', 'macaroni', 'green pepper', 'Worcestershire sauce', 'salt', 'pepper', 'chili powder']);
select cooking_camel_schema.insert('Jiffy Beef Stroganoff',
                                   '["Brown meat.", "Sprinkle onion soup mix and ginger over meat. Arrange layer of noodles over meat and add mushrooms.", "Pour water over noodles.", "Cook on low 20 minutes.", "Blend flour into sour cream and add to stroganoff.", "Cook 3 minutes."]',
                                   '["1 lb. ground beef", "1 pkg. dry onion soup mix", "1/2 tsp. ginger", "3 c. medium noodles", "1 (3 oz.) can sliced mushrooms", "3 c. hot water", "2 Tbsp. flour", "1 c. sour cream"]',
                                   ARRAY ['ground beef', 'onion soup', 'ginger', 'noodles', 'mushrooms', 'water', 'flour', 'sour cream']);
select cooking_camel_schema.insert('Baked Cheese Sandwiches',
                                   '["Make 4 cheese sandwiches (with 2 slices of American cheese in each sandwich).", "Remove crusts and arrange in baking dish.", "Mix eggs, milk and dry mustard and pour over sandwiches.", "Bake in 400\u00b0 oven for 20 minutes or until brown on top."]',
                                   '["5 eggs", "3 c. milk", "1 tsp. mustard", "bread", "cheese slices"]',
                                   ARRAY ['eggs', 'milk', 'mustard', 'bread', 'cheese slices']);
select cooking_camel_schema.insert('TeresaS Brisket',
                                   '["Cover with all ingredients and refrigerate overnight in a 13 x 9-inch pan.", "Next morning add 1 bottle Worcestershire sauce and black pepper.", "Bake in 275\u00b0 oven for 6 to 8 hours.", "Cover with barbecue sauce."]',
                                   '["garlic", "onion", "celery powder", "minced onion", "bottle of liquid smoke", "brisket", "Worcestershire sauce", "black pepper"]',
                                   ARRAY ['garlic', 'onion', 'celery powder', 'onion', 'liquid smoke', 'brisket', 'Worcestershire sauce', 'black pepper']);
select cooking_camel_schema.insert('Heavenly Rice',
                                   '["Cook rice. Drain off excess water.", "While hot, mix in drained pineapple. Add sugar to taste.", "Let set until cold.", "Whip the cream and fold into rice.", "Add a few marshmallows, if you like."]',
                                   '["3/4 c. rice (without salt)", "1 small can pineapple, drained", "sugar to taste", "1 c. cream, whipped", "miniature marshmallows"]',
                                   ARRAY ['rice', 'pineapple', 'sugar', 'cream', 'marshmallows']);
select cooking_camel_schema.insert('Baked Salmon Loaf',
                                   '["You may add 1 1/2 tablespoons dill weed (fresh if possible); I dont."]',
                                   '["1 (1 lb.) can salmon", "1/2 c. chopped celery", "1/4 c. chopped onion", "1/4 lb. chopped fresh mushrooms", "1/4 c. evaporated skim milk", "2 egg whites or egg substitute to equal 1 egg", "1 c. bread crumbs or oat bran cereal"]',
                                   ARRAY ['salmon', 'celery', 'onion', 'fresh mushrooms', 'milk', 'egg whites', 'bread crumbs']);
select cooking_camel_schema.insert('Favorite Vegetable Soup(Low-Fat)  ',
                                   '["In 1 1/2-quart nonstick saucepan, combine onion, broth mix and garlic; cook, stirring occasionally, until onion is translucent. Add remaining ingredients and stir to combine; cover and cook over low heat, stirring occasionally, for about 10 minutes.", "Add 2 cups water and bring to a boil.", "Reduce heat to medium, cover and cook until vegetables are soft, about 20 minutes. Using a slotted spoon, remove about 1/2 cup vegetables from saucepan and set aside.", "In blender container, in 2 batches, puree remaining soup; return pureed mixture to saucepan, add reserved vegetables and heat.", "Makes 2 servings."]',
                                   '["1/4 c. diced onion", "2 packets instant chicken broth and seasoning mix", "2 garlic cloves, minced", "1 1/2 c. thinly sliced zucchini", "1/2 c. each thinly sliced carrots and chopped seeded tomato", "1 tsp. chopped fresh parsley", "1/4 tsp. basil leaves", "1/8 tsp. pepper"]',
                                   ARRAY ['onion', 'packets instant chicken broth', 'garlic', 'zucchini', 'carrots', 'parsley', 'basil', 'pepper']);
select cooking_camel_schema.insert('Sour Cream Lasagna',
                                   '["Cook noodles according to package directions; rinse and drain. Brown hamburger in skillet.", "Add next 6 ingredients; mix well. Cook for 5 minutes; remove from heat.", "Combine noodles with cottage cheese, sour cream and green onions.", "Alternate layers of noodle mixture and meat mixture in 2-quart baking dish, ending with meat mixture.", "Top with Cheddar cheese.", "Bake at 350\u00b0 for 30 minutes, or until heated through."]',
                                   '["1 (8 oz.) pkg. egg dumpling noodles", "1 1/2 lb. ground beef", "1 tsp. salt", "dash of pepper", "1/4 tsp. garlic salt", "1/4 tsp. liquid smoke", "1 (8 oz.) can tomato sauce", "1 Tbsp. brown sugar", "1 c. cottage cheese", "1 (12 oz.) carton sour cream", "6 green onions, chopped", "3/4 c. grated Cheddar cheese"]',
                                   ARRAY ['egg dumpling noodles', 'ground beef', 'salt', 'pepper', 'garlic salt', 'liquid smoke', 'tomato sauce', 'brown sugar', 'cottage cheese', 'sour cream', 'green onions', 'Cheddar cheese']);
select cooking_camel_schema.insert('Tater Tot Casserole',
                                   '["Lightly brown ground meat and onion.", "Drain off fat.", "Spread in bottom of casserole dish.", "Mix cream soup with 1/2 can milk. Spread corn over meat and soup over corn.", "Dont stir.", "Sprinkle cheese over soup.", "Cover top with frozen Tater Tots.", "Bake at 325\u00b0, covered, about 30 to 40 minutes, or longer if potatoes are not done."]',
                                   '["3/4 to 1 lb. ground beef or turkey", "1 small onion, chopped (optional)", "1 can cream soup (celery, mushroom or chicken)", "1 can whole kernel corn, drained", "1 c. shredded Cheddar cheese", "frozen Tater Tots (I use Schwans Quik Taters)"]',
                                   ARRAY ['ground beef', 'onion', 'cream soup', 'whole kernel corn', 'Cheddar cheese', 'Tater']);
select cooking_camel_schema.insert('Earthquake Cake',
                                   '["Prepare cake mix according to package directions.", "Grease 9 x 13-inch pan.", "Combine pecans and coconut; sprinkle in bottom of pan.", "Pour prepared cake mix over pecan and coconut mixture."]',
                                   '["1 1/2 c. chopped pecans", "1 1/2 c. shredded coconut", "1 box German chocolate cake mix", "1/2 c. oleo or margarine", "1 (8 oz.) pkg. cream cheese", "3 c. 4x sugar"]',
                                   ARRAY ['pecans', 'coconut', 'chocolate cake', 'oleo', 'cream cheese']);
select cooking_camel_schema.insert('Raw Gluten',
                                   '["Mix whole wheat flour with water into a firm texture.", "Make sure all flour is mixed well (medium to firm dough).", "Let set for 45 minutes (no less).", "Put dough in a colander and while running cold water, continually squeeze dough to wash out starch from mixture.", "Continue to squeeze dough, while at the same time, making sure dough stays firmly together.", "Keep rinsing until all graininess is removed and water is clear from rinsing.", "Cover with water until ready to use.", "Yield: 1 pound."]',
                                   '["2 lb. whole wheat flour", "1 qt. water"]', ARRAY ['whole wheat flour', 'water']);
select cooking_camel_schema.insert('Lemon Chicken And Zucchini',
                                   '["Skin, split and bone chicken breasts.", "Skin and bone thighs. Cut chicken into 1-inch pieces.", "Blend chicken broth into cornstarch; stir in soy sauce and sugar.", "Set aside."]',
                                   '["1 1/2 lb. chicken breasts and thighs", "1/4 c. chicken broth", "1 Tbsp. cornstarch", "2 Tbsp. soy sauce", "1 tsp. sugar", "2 Tbsp. cooking oil", "1 tsp. grated ginger root", "3 1/2 c. sliced zucchini", "2 Tbsp. lemon juice"]',
                                   ARRAY ['chicken breasts', 'chicken broth', 'cornstarch', 'soy sauce', 'sugar', 'cooking oil', 'ginger root', 'zucchini', 'lemon juice']);
select cooking_camel_schema.insert('Meat Balls',
                                   '["Mix beef, sweet relish, garlic powder, onion powder, onion salt and egg.", "Form into balls.", "Put into bag of Shake N Bake. Cover good.", "Cook at 350\u00b0 for 30 to 40 minutes."]',
                                   '["2 lb. ground beef", "10 oz. jar sweet relish", "2 tsp. garlic powder", "1/2 c. minced onions", "1/2 tsp. onion salt", "1 egg", "1 box barbecue Shake N Bake"]',
                                   ARRAY ['ground beef', 'sweet relish', 'garlic powder', 'onions', 'onion salt', 'egg', 'N']);
select cooking_camel_schema.insert('Butternut Chewies',
                                   '["Beat eggs until light and foamy.", "Beat in sugar, vanilla and margarine until creamy.", "Combine flour, baking powder and salt. Add to egg mixture.", "Mix until blended.", "Stir in nuts.", "Mixture will be stiff.", "Spread in 13 x 9-inch greased pan.", "Bake at 350\u00b0 for 25 to 30 minutes.", "Makes 2 dozen."]',
                                   '["1/2 c. margarine, melted", "2 eggs", "2 c. light brown sugar", "1 tsp. vanilla", "1 1/2 c. flour", "2 tsp. baking powder", "1/2 tsp. salt", "1 c. chopped nuts"]',
                                   ARRAY ['margarine', 'eggs', 'light brown sugar', 'vanilla', 'flour', 'baking powder', 'salt', 'nuts']);
select cooking_camel_schema.insert('Tennessee Tea',
                                   '["Put all ingredients in gallon pitcher. Finish filling with water. Stir. Chill or serve over ice."]',
                                   '["1 c. sugar", "1 c. Country Time Lemonade", "1/2 c. Instant Tea (not lemon flavored)", "1 c. white grape juice"]',
                                   ARRAY ['sugar', 'Country', 'Tea', 'white grape juice']);
select cooking_camel_schema.insert('Apple Waldorf Salad',
                                   '["Chop apples; do not peel.", "Sprinkle with lemon juice.", "Add celery, yogurt, pecans and spices.", "Serve on purple cabbage or lettuce leaf.", "Makes 4 servings.", "Calories:", "61.8.", "Fat grams: 1.405."]',
                                   '["1 Granny Smith apple", "1 red Delicious apple", "1/2 c. celery, chopped", "1 Tbsp. pecans", "1 Tbsp. lemon juice", "1/4 c. nonfat yogurt", "dash of cinnamon", "dash of nutmeg"]',
                                   ARRAY ['apple', 'red Delicious apple', 'celery', 'pecans', 'lemon juice', 'nonfat yogurt', 'cinnamon', 'nutmeg']);
select cooking_camel_schema.insert('JackieS Coconut Pie',
                                   '["Melt margarine.", "Add eggs and sugar to margarine and beat. Add buttermilk and mix thoroughly.", "Add vanilla and coconut. Mix thoroughly.", "Pour into 2 deep dish pie shells.", "Bake at 300\u00b0 for 1 hour."]',
                                   '["1 1/2 sticks butter", "1 c. buttermilk", "3 c. sugar", "7 oz. can coconut", "8 eggs", "2 tsp. vanilla"]',
                                   ARRAY ['butter', 'buttermilk', 'sugar', 'coconut', 'eggs', 'vanilla']);
select cooking_camel_schema.insert('Navy Bean Soup',
                                   '["Mix all ingredients in a large Dutch oven. Add water, if needed to reach your favorite consistency.", "Cook until vegetables are tender, but not mushy!", "Makes 6 servings."]',
                                   '["2 (16 oz.) cans navy beans, undrained", "1/2 c. diced salt pork (optional)", "2 (14 1/2 oz.) cans stewed tomatoes, undrained", "2 medium potatoes, peeled and diced", "2 small onions, diced", "2 carrots, diced", "1 Tbsp. salt", "1/2 tsp. pepper", "celery salt to taste"]',
                                   ARRAY ['navy beans', 'salt pork', 'tomatoes', 'potatoes', 'onions', 'carrots', 'salt', 'pepper', 'celery salt']);
select cooking_camel_schema.insert('Layered Banana Pineapple Dessert',
                                   '["Mix graham cracker crumbs, sugar and margarine in a 13 x 9-inch pan.", "Press evenly onto bottom of pan.", "Arrange banana slices on crust.", "Beat cream cheese in large bowl with wire whisk until smooth.", "Gradually beat in milk.", "Add pudding mixes.", "Beat until well blended.", "Spread evenly over banana slices.", "Spoon pineapple evenly over pudding mixture.", "Spread with whipped topping over pineapple.", "Refrigerate 3 hours or until ready to serve."]',
                                   '["1 1/2 c. graham cracker crumbs", "1/4 c. sugar", "1/3 c. margarine or butter, melted", "3 bananas, sliced", "1 (8 oz.) pkg. cream cheese, softened", "3 1/2 c. cold milk", "2 pkg. vanilla instant pudding and pie filling", "1 (20 oz.) can crushed pineapple, drained", "1 (8 oz.) tub Cool Whip, thawed"]',
                                   ARRAY ['graham cracker crumbs', 'sugar', 'margarine', 'bananas', 'cream cheese', 'cold milk', 'vanilla instant pudding', 'pineapple']);
select cooking_camel_schema.insert('Scalloped Potatoes',
                                   '["Saute the onion in the butter until translucent.", "Add the potatoes and combine.", "Add the lemon juice, thyme and salt.", "Mix well."]',
                                   '["1 large onion, sliced thin", "1 Tbsp. butter", "2 large potatoes, sliced thin", "2 Tbsp. lemon juice", "1 tsp. thyme", "1/2 tsp. salt", "nonstick vegetable cooking spray", "1 Tbsp. whole wheat flour", "1 c. skim milk", "2 Tbsp. bread crumbs"]',
                                   ARRAY ['onion', 'butter', 'potatoes', 'lemon juice', 'thyme', 'salt', 'nonstick vegetable cooking spray', 'whole wheat flour', 'milk', 'bread crumbs']);
select cooking_camel_schema.insert('Herb Butter',
                                   '["Cream butter and lemon juice.", "Beat in herbs, salt and pepper and chill.", "Use on corn-on-the-cob or other vegetables."]',
                                   '["1/4 lb. Heritage butter, room temperature", "1 Tbsp. lemon juice", "3 Tbsp. fresh herb parsley", "3 Tbsp. taragon basil", "salt and pepper to taste"]',
                                   ARRAY ['butter', 'lemon juice', 'fresh herb parsley', 'taragon basil', 'salt']);
select cooking_camel_schema.insert('Turnip Greens',
                                   '["Wash greens in cold water to remove grit or any dirt.", "In a large pot filled 3/4 full of water, add the bacon grease and salt. Bring to a boil.", "Add the greens by the handful to the pot, letting them have a", "little time to start to cook down before adding more.", "When pot is full, you will need to poke the greens down for a few minutes as they like to come to the top of the pot and run over.", "Add 1/4 teaspoon of baking soda to the greens to take the bitterness out.", "Cook at a boil until greens are tender, perhaps a half hour.", "Drain well.", "While greens are draining in the colander, cut them up using two knives."]',
                                   '["1 bucket turnip greens", "1 c. bacon grease", "1 Tbsp. salt", "1/4 tsp. baking soda"]',
                                   ARRAY ['greens', 'bacon grease', 'salt', 'baking soda']);
select cooking_camel_schema.insert('Bourbon Balls',
                                   '["Beat butter in medium-size bowl until light and fluffy.", "Beat in gradually 10x confectioners sugar.", "Slowly beat in bourbon. Chill 1 hour or until mixture is stiff enough to shape.", "Roll into 1-inch balls.", "Arrange in single layer on wax paper-lined tray. Chill 1 hour.", "Melt chocolate in top of double boiler over simmering water.", "Remove chocolate from heat; cool until a good dipping consistency.", "Dip bourbon balls with 3-pronged fork halfway into chocolate.", "Return to wax paper-lined tray.", "Place pecan half on top of each ball.", "When all the bourbon balls have been dipped, return tray to refrigerator.", "Chill about 30 minutes or until firm. Makes about 3 dozen."]',
                                   '["1/2 c. (1 stick) butter", "1 lb. (1 box) 10x confectioners sugar", "4 1/2 tsp. 100 proof bourbon", "8 sq. (1 oz. each) semi-sweet chocolate, broken into pieces", "36 pecan halves"]',
                                   ARRAY ['butter', 'confectioners sugar', 'bourbon', 'semi-sweet chocolate', 'pecan']);
select cooking_camel_schema.insert('Pinto Beans',
                                   '["Look over beans and remove all split beans and gravel (if any).", "Rinse well.", "Put into 2 to 3-quart saucepan.", "Add ginger; bring to boil and cover with lid.", "Cook until beans have swollen and turned color, about 1 hour.", "Add grease and salt and continue to cook, keeping water about 1-inch above beans at all times.", "When beans begin to get tender, add sugar and cook until very tender."]',
                                   '["1 1/2 c. dry beans", "3/4 tsp. ground ginger", "3 Tbsp. melted meat drippings", "1 1/2 tsp. salt or to taste", "1 heaping Tbsp. sugar"]',
                                   ARRAY ['beans', 'ground ginger', 'melted meat drippings', 'salt', 'sugar']);
select cooking_camel_schema.insert('Cook While You Sleep Cookies',
                                   '["Preheat oven to 350\u00b0.", "Beat egg whites until foamy; add salt and cream of tartar.", "Beat until stiff.", "Add 2 tablespoons of sugar at a time, beating well after each addition.", "Stir in vanilla, chocolate chips, nuts and coconut.", "Drop by teaspoon onto foil lined cookie sheets.", "Put in the oven and turn off oven immediately.", "Do not open the door for at least 8 hours.", "Carefully remove cookies from foil.", "Makes 40 to 50 cookies."]',
                                   '["2 egg whites", "pinch of salt", "1 c. chocolate chips", "1/4 tsp. cream of tartar", "2/3 c. sugar", "1 c. chopped nuts", "coconut (optional)"]',
                                   ARRAY ['egg whites', 'salt', 'chocolate chips', 'cream of tartar', 'sugar', 'nuts', 'coconut']);
select cooking_camel_schema.insert('Chili Spaghetti',
                                   '["Fry mango and onion with piece of butter, then brown ground beef in same skillet.", "Pour tomato sauce and chili powder in.", "Let simmer together about 20 minutes."]',
                                   '["1 1/2 lb. hamburger", "1 mango, chopped (green pepper)", "1 onion, chopped", "3 cans tomato sauce", "dash of chili powder"]',
                                   ARRAY ['hamburger', 'mango', 'onion', 'tomato sauce', 'chili powder']);
select cooking_camel_schema.insert('Cherry Delight',
                                   '["Into a medium size bowl, put in pineapple. Add dry jello. Stir. Then add cottage cheese. Stir and finally add Cool Whip. Stir. Refrigerate."]',
                                   '["1 small container Cool Whip", "1 small can crushed pineapple, drained", "1 small pkg. cherry jello", "1 small container cottage cheese"]',
                                   ARRAY ['pineapple', 'cherry jello', 'cottage cheese']);
select cooking_camel_schema.insert('Banana Split Dessert',
                                   '["Combine cracker crumbs and 6 tablespoons melted butter, mixing well.", "Press crumb mixture into bottoms of a 13 x 9-inch pan. Combine 1/2 cup butter, sugar, vanilla and eggs.", "Beat until fluffy.", "Spread sugar mixture over crumb layer.", "Slice bananas lengthwise.", "Arrange over sugar mixture.", "Spoon pineapple over bananas.", "Cover pineapple layer with whipped cream.", "Sprinkle with nuts.", "Garnish with cherries.", "Chill for 6 hours before serving."]',
                                   '["2 c. crushed graham crackers", "2 c. powdered sugar", "2 eggs, lightly beaten", "1 large can crushed pineapple", "1/4 c. crushed nuts", "butter", "1 tsp. vanilla extract", "firm bananas", "2 c. whipped cream", "maraschino cherries"]',
                                   ARRAY ['graham crackers', 'powdered sugar', 'eggs', 'pineapple', 'nuts', 'butter', 'vanilla extract', 'bananas', 'whipped cream', 'maraschino cherries']);
select cooking_camel_schema.insert('Strawberry Salad',
                                   '["Add water to Jell-O.", "Stir to dissolve.", "Add strawberries, bananas and pineapple.", "Pour half into pan.", "Let harden."]',
                                   '["2 crushed bananas", "1 can crushed pineapple", "1 small pkg. frozen strawberries or 1 pt. fresh strawberries", "2 pkg. strawberry Jell-O", "1 c. boiling water", "1 carton sour cream"]',
                                   ARRAY ['bananas', 'pineapple', 'frozen strawberries', 'strawberry Jell-O', 'boiling water', 'sour cream']);
select cooking_camel_schema.insert('Peanut Butter Pie',
                                   '["Beat eggs.", "Mix eggs, corn syrup, sugar, peanut butter and vanilla together.", "Pour into unbaked pie crust.", "Bake at 350\u00b0 for 45 to 60 minutes, until top is brown and crisp."]',
                                   '["2 eggs", "1 c. corn syrup", "1/2 c. peanut butter", "1 tsp. vanilla", "1 unbaked 8-inch pie crust"]',
                                   ARRAY ['eggs', 'corn syrup', 'peanut butter', 'vanilla', 'crust']);
select cooking_camel_schema.insert('Foolproof Fudge',
                                   '["In a heavy saucepan, over low heat, melt chips with milk. Remove from heat, stir in remaining ingredients.", "Spread evenly in 8-inch square dish.", "Chill 2 hours before cutting, then store at room temperature.", "Makes 1 3/4 pounds."]',
                                   '["3 (6 oz.) pkg. chocolate chips", "1 (14 oz.) can Eagle Brand milk", "dash of salt", "1 1/2 tsp. vanilla", "1/2 c. chopped nuts"]',
                                   ARRAY ['chocolate chips', 'milk', 'salt', 'vanilla', 'nuts']);

drop function cooking_camel_schema.insert;

end;
