<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<%
    String ctx = request.getContextPath();

    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");

    if (restaurants == null) {
        restaurants = new java.util.ArrayList<Restaurant>();
    }

    String cuisine = request.getParameter("cuisine");
    String search = request.getParameter("search");

    if (cuisine == null) cuisine = "";
    if (search == null) search = "";

    String escCuisine = cuisine.replace("&", "&amp;")
        .replace("\"", "&quot;")
        .replace("<", "&lt;")
        .replace(">", "&gt;");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Restaurants | Mana Ruchi</title>

    <link rel="stylesheet" href="<%= ctx %>/css/navbar.css">
    <link rel="stylesheet" href="<%= ctx %>/css/restaurant.css">
    <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
</head>

<body class="mr-restaurants-page">

<%@ include file="includes/navbar.jsp" %>

<main class="mr-restaurants-main">


    <!-- Cuisine shortcuts -->
    <section class="mr-cuisine-shortcuts">
        <h2>Explore cuisines</h2>

        <div class="mr-cuisine-chips">
            <a href="<%= ctx %>/restaurants"
               class="mr-cuisine-chip <%= cuisine.isEmpty() ? "active" : "" %>">
                All
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=Biryani"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("Biryani") ? "active" : "" %>">
                Biryani
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=South%20Indian"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("South Indian") ? "active" : "" %>">
                South Indian
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=North%20Indian"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("North Indian") ? "active" : "" %>">
                North Indian
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=Burgers"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("Burgers") ? "active" : "" %>">
                Burgers
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=Pizza"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("Pizza") ? "active" : "" %>">
                Pizza
            </a>

            <a href="<%= ctx %>/restaurants?cuisine=Chinese"
               class="mr-cuisine-chip <%= cuisine.equalsIgnoreCase("Chinese") ? "active" : "" %>">
                Chinese
            </a>
        </div>
    </section>

    <section class="mr-restaurant-layout">

        <div class="mr-restaurant-results">

            <div class="mr-results-toolbar">
                <div>
                    <h2>All restaurants</h2>
                    <p>Find the right place for your cravings.</p>
                </div>

                <div class="mr-results-actions">
                    <button type="button" id="mrOpenFilters"
                            class="mr-open-filters"
                            aria-controls="mrFilterSidebar"
                            aria-expanded="false">
                        <span aria-hidden="true">&#9776;</span> Filters
                    </button>

                    <label class="mr-sort-control" for="mrSortRestaurants">
                        <span>Sort by</span>
                        <select id="mrSortRestaurants">
                            <option value="recommended">Recommended</option>
                            <option value="rating">Highest rated</option>
                            <option value="fastest">Fastest delivery</option>
                            <option value="name">Restaurant name</option>
                        </select>
                    </label>
                </div>
            </div>

            <div class="mr-restaurant-grid" id="mrRestaurantGrid">

                <% for (Restaurant r : restaurants) {

                    String restaurantName = r.getName();
                    String restaurantImage = r.getImagePath();
                    String restaurantCuisine = r.getCuisineType();
                    String restaurantLocation = r.getAddress();

                    double restaurantRating = r.getRating();

                    String safeName = restaurantName == null
                        ? "" : restaurantName;

                    String safeCuisine = restaurantCuisine == null
                        ? "" : restaurantCuisine;

                    String safeLocation = restaurantLocation == null
                        ? "" : restaurantLocation;

                    String imagePath = restaurantImage == null
                        ? "" : restaurantImage.trim();

                    String imageUrl;

                    if (imagePath.startsWith("http://")
                            || imagePath.startsWith("https://")) {
                        imageUrl = imagePath;
                    } else if (imagePath.isEmpty()) {
                        imageUrl = ctx + "/images/restaurant-placeholder.png";
                    } else {
                        imageUrl = ctx + "/"
                            + (imagePath.startsWith("/")
                                ? imagePath.substring(1) : imagePath);
                    }

                    String escapedName = safeName.replace("&", "&amp;")
                        .replace("\"", "&quot;")
                        .replace("<", "&lt;")
                        .replace(">", "&gt;");

                    String escapedCardCuisine = safeCuisine.replace("&", "&amp;")
                        .replace("\"", "&quot;")
                        .replace("<", "&lt;")
                        .replace(">", "&gt;");

                    String escapedLocation = safeLocation.replace("&", "&amp;")
                        .replace("<", "&lt;")
                        .replace(">", "&gt;");

                    String filterName = safeName.toLowerCase()
                        .replace("\"", "&quot;");

                    String filterCuisine = safeCuisine.toLowerCase()
                        .replace("\"", "&quot;");
                %>

                <a class="mr-restaurant-card"
                   href="<%= ctx %>/menu?restaurantId=<%= r.getRestaurantId() %>"
                   data-name="<%= filterName %>"
                   data-cuisine="<%= filterCuisine %>"
                   data-rating="<%= restaurantRating %>"
                   data-delivery="30"
                   data-veg="false">

                    <div class="mr-restaurant-image-wrap">
                        <img class="mr-restaurant-image"
                             src="<%= imageUrl %>"
                             alt="<%= escapedName %>"
                             loading="lazy"
                             onerror="this.onerror=null;this.src='<%= ctx %>/images/restaurant-placeholder.png';">
                    </div>

                    <div class="mr-restaurant-info">
                        <h3><%= escapedName %></h3>

                        <div class="mr-restaurant-meta">
                            <span class="mr-rating">
                                <span class="mr-rating-star">&#9733;</span>
                                <%= restaurantRating %>
                            </span>

                            <span class="mr-meta-dot">&#8226;</span>
                            <span>30 mins</span>
                        </div>

                        <p class="mr-restaurant-cuisine">
                            <%= escapedCardCuisine %>
                        </p>

                        <p class="mr-restaurant-location">
                            <span>&#9679;</span>
                            <%= escapedLocation %>
                        </p>
                    </div>
                </a>

                <% } %>

            </div>

            <div class="mr-no-restaurants" id="mrNoRestaurants"
                 <%= restaurants.isEmpty() ? "" : "hidden" %>>
                <span class="mr-empty-icon">&#127869;</span>
                <h3>No restaurants found</h3>
                <p>Try another cuisine or change your filters.</p>
                <button type="button" id="mrResetEmpty">
                    Clear filters
                </button>
            </div>

        </div>

        <!-- Filter drawer: hidden until opened -->
        <aside class="mr-filter-sidebar"
               id="mrFilterSidebar"
               aria-hidden="true"
               inert>

            <div class="mr-filter-heading">
                <div>
                    <h2>Filters</h2>
                    <p>Find your perfect meal</p>
                </div>

                <div class="mr-filter-heading-actions">
                    <button type="button" id="mrClearFilters"
                            class="mr-clear-filters">
                        Clear all
                    </button>

                    <button type="button" id="mrCloseFilters"
                            class="mr-close-filters"
                            aria-label="Close filters">
                        &times;
                    </button>
                </div>
            </div>

            <div class="mr-filter-group">
                <h3>Rating</h3>

                <label class="mr-filter-option">
                    <input type="radio" name="ratingFilter" value="0" checked>
                    <span>All ratings</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="ratingFilter" value="3.5">
                    <span>3.5+</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="ratingFilter" value="4">
                    <span>4.0+</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="ratingFilter" value="4.5">
                    <span>4.5+</span>
                </label>
            </div>

            <div class="mr-filter-group">
                <h3>Delivery time</h3>

                <label class="mr-filter-option">
                    <input type="radio" name="deliveryFilter" value="0" checked>
                    <span>Any time</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="deliveryFilter" value="20">
                    <span>Under 20 mins</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="deliveryFilter" value="30">
                    <span>Under 30 mins</span>
                </label>

                <label class="mr-filter-option">
                    <input type="radio" name="deliveryFilter" value="40">
                    <span>Under 40 mins</span>
                </label>
            </div>

            <div class="mr-filter-group">
                <h3>Cuisine</h3>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="south indian">
                    <span>South Indian</span>
                </label>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="north indian">
                    <span>North Indian</span>
                </label>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="biryani">
                    <span>Biryani</span>
                </label>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="chinese">
                    <span>Chinese</span>
                </label>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="pizza">
                    <span>Pizza</span>
                </label>

                <label class="mr-filter-option">
                    <input type="checkbox" name="cuisineFilter" value="burger">
                    <span>Burgers</span>
                </label>
            </div>

            <div class="mr-filter-group">
                <h3>Food preference</h3>

                <label class="mr-filter-option">
                    <input type="checkbox" id="mrVegOnly">
                    <span>Vegetarian options only</span>
                </label>
            </div>

            <button type="button" id="mrApplyFilters"
                    class="mr-apply-filters">
                Apply filters
            </button>
        </aside>

    </section>

    <div class="mr-filter-overlay" id="mrFilterOverlay"
         aria-hidden="true"></div>

</main>

<jsp:include page="/includes/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function () {
    const grid = document.getElementById("mrRestaurantGrid");
    const noResults = document.getElementById("mrNoRestaurants");
    const sidebar = document.getElementById("mrFilterSidebar");
    const overlay = document.getElementById("mrFilterOverlay");

    const openButton = document.getElementById("mrOpenFilters");
    const closeButton = document.getElementById("mrCloseFilters");
    const applyButton = document.getElementById("mrApplyFilters");
    const clearButton = document.getElementById("mrClearFilters");
    const resetButton = document.getElementById("mrResetEmpty");
    const sortSelect = document.getElementById("mrSortRestaurants");
    const vegOnly = document.getElementById("mrVegOnly");

    const cards = Array.from(grid.querySelectorAll(".mr-restaurant-card"));
    const originalOrder = new Map(
        cards.map((card, index) => [card, index])
    );

    const params = new URLSearchParams(window.location.search);
    const activeCuisine = (params.get("cuisine") || "").toLowerCase().trim();
    const searchTerm = (params.get("search") || "").toLowerCase().trim();

    function openFilters() {
        sidebar.classList.add("is-open");
        overlay.classList.add("is-visible");

        sidebar.setAttribute("aria-hidden", "false");
        sidebar.inert = false;
        overlay.setAttribute("aria-hidden", "false");

        openButton.setAttribute("aria-expanded", "true");
        document.body.classList.add("mr-filters-open");
        closeButton.focus();
    }

    function closeFilters() {
        sidebar.classList.remove("is-open");
        overlay.classList.remove("is-visible");

        sidebar.setAttribute("aria-hidden", "true");
        sidebar.inert = true;
        overlay.setAttribute("aria-hidden", "true");

        openButton.setAttribute("aria-expanded", "false");
        document.body.classList.remove("mr-filters-open");
        openButton.focus();
    }

    function selectedValue(name) {
        const selected = document.querySelector(
            'input[name="' + name + '"]:checked'
        );
        return selected ? Number(selected.value) : 0;
    }

    function sortVisibleCards() {
        const mode = sortSelect.value;
        const visible = cards.filter(card => !card.hidden);
        const hidden = cards.filter(card => card.hidden);

        visible.sort(function (a, b) {
            if (mode === "rating") {
                return Number(b.dataset.rating || 0) -
                       Number(a.dataset.rating || 0);
            }

            if (mode === "fastest") {
                return Number(a.dataset.delivery || 999) -
                       Number(b.dataset.delivery || 999);
            }

            if (mode === "name") {
                return (a.dataset.name || "").localeCompare(
                    b.dataset.name || ""
                );
            }

            return originalOrder.get(a) - originalOrder.get(b);
        });

        visible.concat(hidden).forEach(card => grid.appendChild(card));
    }

    function applyFilters() {
        const minRating = selectedValue("ratingFilter");
        const maxDelivery = selectedValue("deliveryFilter");

        const selectedCuisines = Array.from(
            document.querySelectorAll(
                'input[name="cuisineFilter"]:checked'
            )
        ).map(input => input.value.toLowerCase());

        const vegetarianOnly = vegOnly.checked;

        cards.forEach(function (card) {
            const name = (card.dataset.name || "").toLowerCase();
            const cuisineValue = (card.dataset.cuisine || "").toLowerCase();
            const rating = Number(card.dataset.rating || 0);
            const delivery = Number(card.dataset.delivery || 0);
            const vegetarian = card.dataset.veg === "true";

            const matchesShortcut =
                !activeCuisine || cuisineValue.includes(activeCuisine);

            const matchesSearch =
                !searchTerm ||
                name.includes(searchTerm) ||
                cuisineValue.includes(searchTerm);

            const matchesRating = rating >= minRating;

            const matchesDelivery =
                maxDelivery === 0 ||
                (delivery > 0 && delivery < maxDelivery);

            const matchesCuisine =
                selectedCuisines.length === 0 ||
                selectedCuisines.some(value => cuisineValue.includes(value));

            const matchesVeg = !vegetarianOnly || vegetarian;

            card.hidden = !(
                matchesShortcut &&
                matchesSearch &&
                matchesRating &&
                matchesDelivery &&
                matchesCuisine &&
                matchesVeg
            );
        });

        sortVisibleCards();

        const visibleCount = cards.filter(card => !card.hidden).length;
        noResults.hidden = visibleCount > 0;
    }

    function clearFilters() {
        const allRating = document.querySelector(
            'input[name="ratingFilter"][value="0"]'
        );
        const anyDelivery = document.querySelector(
            'input[name="deliveryFilter"][value="0"]'
        );

        if (allRating) allRating.checked = true;
        if (anyDelivery) anyDelivery.checked = true;

        document.querySelectorAll('input[name="cuisineFilter"]')
            .forEach(input => input.checked = false);

        vegOnly.checked = false;
        sortSelect.value = "recommended";

        applyFilters();
    }

    openButton.addEventListener("click", openFilters);
    closeButton.addEventListener("click", closeFilters);
    overlay.addEventListener("click", closeFilters);

    applyButton.addEventListener("click", function () {
        applyFilters();
        closeFilters();
    });

    clearButton.addEventListener("click", clearFilters);
    resetButton.addEventListener("click", clearFilters);
    sortSelect.addEventListener("change", sortVisibleCards);

    document.querySelectorAll(
        'input[name="ratingFilter"], input[name="deliveryFilter"], ' +
        'input[name="cuisineFilter"], #mrVegOnly'
    ).forEach(input => input.addEventListener("change", applyFilters));

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" &&
            sidebar.classList.contains("is-open")) {
            closeFilters();
        }
    });

    applyFilters();
});
</script>

</body>
</html>