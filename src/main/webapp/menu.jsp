
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<Menu> menuList =
        (List<Menu>) request.getAttribute("menuList");

    Integer restaurantId =
        (Integer) request.getAttribute("restaurantId");

    Restaurant restaurant =
        (Restaurant) request.getAttribute("restaurant");

    String selectedFoodType =
        (String) request.getAttribute("selectedFoodType");

    if (selectedFoodType == null) {
        selectedFoodType = "All";
    }

    Cart cart = (Cart) session.getAttribute("cart");
    String cartError = request.getParameter("cartError");
    String ctx = request.getContextPath();

    if (menuList == null) {
        menuList = new java.util.ArrayList<Menu>();
    }

    if (restaurantId == null && restaurant != null) {
        restaurantId = restaurant.getRestaurantId();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Menu | Mana Ruchi</title>

    <link rel="stylesheet" href="<%= ctx %>/css/menu.css">
    <link rel="stylesheet" href="<%= ctx %>/css/navbar.css">
    <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
</head>

<body>

    <jsp:include page="/includes/navbar.jsp" />

    <main class="menu-page">

        <!-- RESTAURANT DETAILS -->
        <% if (restaurant != null) { %>

            <section class="selected-restaurant">

                <div class="restaurant-info-layout">

                    <div class="restaurant-info-image">

                        <% if (restaurant.getImagePath() != null
                              && !restaurant.getImagePath().trim().isEmpty()) { %>

                            <img
                                src="<%= restaurant.getImagePath() %>"
                                alt="<%= restaurant.getName() %>"
                                onerror="this.style.display='none';"
                            >

                        <% } else { %>

                            <div class="restaurant-image-placeholder">
                                🍽️
                            </div>

                        <% } %>

                    </div>

                    <div class="restaurant-info-content">

                        <span class="restaurant-eyebrow">
                            YOUR SELECTED RESTAURANT
                        </span>

                        <h2><%= restaurant.getName() %></h2>

                        <p class="restaurant-cuisine">
                            <%= restaurant.getCuisineType() %> Cuisine
                        </p>

                        <div class="restaurant-meta">

                            <span>
                                <span class="rating-star">★</span>
                                <%= restaurant.getRating() %> Rating
                            </span>

                            <span>
                                <span class="meta-icon">◷</span>
                                <%= restaurant.getDeliveryTime() %> min delivery
                            </span>

                        </div>

                        <p class="restaurant-address">
                            <span class="meta-icon">📍</span>
                            <%= restaurant.getAddress() %>
                        </p>

                    </div>

                </div>

            </section>

        <% } else { %>

            <div class="menu-error">
                Restaurant details are unavailable.
                Please select a restaurant again.
            </div>

        <% } %>

        <!-- MENU SECTION -->
        <section class="menu-section">

            <div class="menu-section-heading">

                <div class="menu-section-title">

                    <span class="section-eyebrow">
                        SOMETHING DELICIOUS AWAITS
                    </span>

                    <h2>Explore the Menu</h2>

                    <p>
                        Find your favourites, freshly prepared for you.
                    </p>

                </div>

                <div class="menu-count">
                    <%= menuList.size() %>
                    <span> dishes to explore</span>
                </div>

            </div>

            <!-- FOOD FILTERS -->
            <div class="menu-filters">

                <div class="filter-heading">
                    <span class="filter-heading-icon">☷</span>
                    Choose your preference
                </div>

                <div class="filter-buttons">

                    <a
                        class="food-filter all-filter <%= "All".equals(selectedFoodType) ? "active" : "" %>"
                        href="<%= ctx %>/menu?restaurantId=<%= restaurantId %>&amp;foodType=All">

                        <span class="filter-symbol">☷</span>
                        All Items
                    </a>

                    <a
                        class="food-filter veg-filter <%= "Veg".equals(selectedFoodType) ? "active" : "" %>"
                        href="<%= ctx %>/menu?restaurantId=<%= restaurantId %>&amp;foodType=Veg">

                        <span class="food-type-indicator veg-indicator"></span>
                        Veg
                    </a>

                    <a
                        class="food-filter non-veg-filter <%= "Non-Veg".equals(selectedFoodType) ? "active" : "" %>"
                        href="<%= ctx %>/menu?restaurantId=<%= restaurantId %>&amp;foodType=Non-Veg">

                        <span class="food-type-indicator non-veg-indicator"></span>
                        Non-Veg
                    </a>

                </div>

            </div>

            <!-- CART ERROR -->
            <% if (cartError != null) { %>

                <div class="menu-error">

                    <% if ("differentRestaurant".equals(cartError)) { %>

                        Your cart contains items from another restaurant.
                        Clear your cart before adding items from this restaurant.

                    <% } else { %>

                        Unable to update your cart. Please try again.

                    <% } %>

                </div>

            <% } %>

            <!-- MENU CARDS -->
            <div class="menu-grid">

                <% if (menuList.isEmpty()) { %>

                    <div class="menu-empty-state">

                        <div class="empty-menu-icon">🍽️</div>

                        <h3>No dishes found</h3>

                        <p>
                            Try another food filter to discover more dishes.
                        </p>

                        <a
                            class="food-filter all-filter empty-state-button"
                            href="<%= ctx %>/menu?restaurantId=<%= restaurantId %>&amp;foodType=All">
                            View All Items
                        </a>

                    </div>

                <% } else { %>

                    <% for (Menu menu : menuList) {

                        int quantity = 0;

                        if (cart != null && cart.getItems() != null) {

                            for (CartItem item : cart.getItems()) {

                                if (item.getMenu() != null
                                    && item.getMenu().getMenuId()
                                       == menu.getMenuId()) {

                                    quantity = item.getQuantity();
                                    break;
                                }
                            }
                        }

                        boolean veg =
                            "Veg".equalsIgnoreCase(menu.getFoodType());

                        boolean nonVeg =
                            "Non-Veg".equalsIgnoreCase(menu.getFoodType());
                    %>

                        <article class="menu-card">

                            <!-- FOOD IMAGE -->
                            <div class="menu-image-wrapper">

                                <% if (menu.getImagePath() != null
                                      && !menu.getImagePath().trim().isEmpty()) { %>

                                    <img
                                        class="menu-image"
                                        src="<%= menu.getImagePath() %>"
                                        alt="<%= menu.getItemName() %>"
                                        loading="lazy"
                                        onerror="this.style.display='none';"
                                    >

                                <% } else { %>

                                    <div class="menu-image-placeholder">
                                        🍲
                                    </div>

                                <% } %>

                                <% if (veg) { %>

                                    <span class="food-type-badge veg-badge">
                                        <span class="food-type-indicator veg-indicator"></span>
                                        Veg
                                    </span>

                                <% } else if (nonVeg) { %>

                                    <span class="food-type-badge non-veg-badge">
                                        <span class="food-type-indicator non-veg-indicator"></span>
                                        Non-Veg
                                    </span>

                                <% } %>

                            </div>

                            <!-- FOOD DETAILS -->
                            <div class="menu-card-content">

                                <h3 class="menu-item-name">
                                    <%= menu.getItemName() %>
                                </h3>

                                <p class="menu-description">
                                    <%= menu.getDescription() != null
                                        ? menu.getDescription()
                                        : "Deliciously prepared for you." %>
                                </p>

                                <div class="menu-card-bottom">

                                    <span class="menu-price">
                                        ₹<%= String.format("%.2f", menu.getPrice()) %>
                                    </span>

                                    <% if (menu.isAvailable()) { %>

                                        <span class="availability-badge available">
                                            <span class="availability-dot"></span>
                                            Available
                                        </span>

                                    <% } else { %>

                                        <span class="availability-badge unavailable">
                                            Unavailable
                                        </span>

                                    <% } %>

                                </div>

                                <!-- CART CONTROLS -->
                                <div class="menu-card-actions">

                                    <% if (!menu.isAvailable()) { %>

                                        <button
                                            type="button"
                                            class="add-cart-button disabled-button"
                                            disabled>
                                            Currently Unavailable
                                        </button>

                                    <% } else if (quantity > 0) { %>

                                        <div class="quantity-controls">

                                            <!-- DECREASE QUANTITY -->
                                            <form action="<%= ctx %>/cart"
                                                  method="post">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update">
                                                 <input type="hidden" name="returnTo" value="menu">

                                                <input type="hidden"
                                                       name="menuId"
                                                       value="<%= menu.getMenuId() %>">

                                                <input type="hidden"
                                                       name="restaurantId"
                                                       value="<%= restaurantId %>">

                                                <input type="hidden"
                                                       name="quantity"
                                                       value="<%= quantity - 1 %>">

                                                <button
                                                    type="submit"
                                                    class="quantity-button decrease-button"
                                                    aria-label="Decrease quantity">
                                                    −
                                                </button>

                                            </form>

                                            <span class="quantity-value">
                                                <%= quantity %>
                                            </span>

                                            <!-- INCREASE QUANTITY -->
                                            <form action="<%= ctx %>/cart"
                                                  method="post">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update">
                                                <input type="hidden" name="returnTo" value="menu">

                                                <input type="hidden"
                                                       name="menuId"
                                                       value="<%= menu.getMenuId() %>">

                                                <input type="hidden"
                                                       name="restaurantId"
                                                       value="<%= restaurantId %>">

                                                <input type="hidden"
                                                       name="quantity"
                                                       value="<%= quantity + 1 %>">

                                                <button
                                                    type="submit"
                                                    class="quantity-button increase-button"
                                                    aria-label="Increase quantity">
                                                    +
                                                </button>

                                            </form>

                                        </div>

                                    <% } else { %>

                                        <!-- ADD TO CART -->
                                        <form action="<%= ctx %>/cart"
                                              method="post"
                                              class="add-cart-form">

                                            <input type="hidden"
                                                   name="action"
                                                   value="add">

                                            <input type="hidden"
                                                   name="menuId"
                                                   value="<%= menu.getMenuId() %>">

                                            <input type="hidden"
                                                   name="restaurantId"
                                                   value="<%= restaurantId %>">

                                            <input type="hidden"
                                                   name="quantity"
                                                   value="1">

                                            <button
                                                type="submit"
                                                class="add-cart-button">
                                                <span>+</span>
                                                Add to Cart
                                            </button>

                                        </form>

                                    <% } %>

                                </div>

                            </div>

                        </article>

                    <% } %>

                <% } %>

            </div>

        </section>

    </main>

    <jsp:include page="/includes/footer.jsp" />

    <script>
        document.querySelectorAll(".menu-card").forEach(function(card) {
            card.addEventListener("pointermove", function(event) {
                const rect = card.getBoundingClientRect();

                card.style.setProperty(
                    "--mouse-x",
                    (event.clientX - rect.left) + "px"
                );

                card.style.setProperty(
                    "--mouse-y",
                    (event.clientY - rect.top) + "px"
                );
            });
        });
    </script>

</body>
</html>
