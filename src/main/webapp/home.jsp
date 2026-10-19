
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<%
    String ctx = request.getContextPath();
    List<Restaurant> featuredRestaurants =
        (List<Restaurant>) request.getAttribute("featuredRestaurants");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#123C2F">
    <meta name="description"
          content="Discover delicious food, explore cuisines and order your favourite meals with Mana Ruchi.">

    <title>Mana Ruchi | Good Food, Great Mood</title>

    <link rel="stylesheet" href="<%= ctx %>/css/navbar.css">
    <link rel="stylesheet" href="<%= ctx %>/css/home.css">
    <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
</head>

<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="mr-home">

    <!-- 1. HERO SECTION -->
    <section class="mr-home-hero">

        <img class="mr-home-hero-bg"
             src="<%= ctx %>/images/food-hero.png"
             alt="Delicious freshly prepared food"
             fetchpriority="high">

        <div class="mr-home-container mr-hero-layout">

            <div class="mr-home-hero-content">

                <span class="mr-home-hero-label">
                    <span class="mr-home-hero-dot"></span>
                    GOOD FOOD, DELIVERED WITH LOVE
                </span>

                <h1>
                    Good Food,<br>
                    Right When<br>
                    <span>You Want It.</span>
                </h1>

                <p class="mr-home-hero-description">
                    Your favourite meals, delivered hot and fresh
                    to your door. Discover delicious food and make
                    every meal special with Mana Ruchi.
                </p>

                <div class="mr-hero-actions">
                    <a href="<%= ctx %>/restaurants"
                       class="mr-home-featured-button">
                        Explore Restaurants <span>→</span>
                    </a>
                </div>

            </div>
        </div>
    </section>


   
<!-- 2. SEARCH BAR -->
<section class="mr-find-section">
    <div class="mr-home-container">

        <div class="mr-find-panel">

            <div class="mr-find-intro">
                <span class="mr-home-kicker">YOUR NEXT FOOD STOP</span>
                <h2>Find Something<br>Delicious</h2>
                <p>
                    Search for your favourite dishes
                    and discover restaurants near you.
                </p>
            </div>

            <div class="mr-find-content">

                <form action="<%= ctx %>/restaurants"
                      method="get"
                      class="mr-find-search"
                      id="mrFindSearchForm">

                    <!-- LOCATION FIELD -->
                    <div class="mr-find-field-wrap">
                        <div class="mr-find-location">

                            <button type="button"
                                    id="mrLocateButton"
                                    class="mr-location-button"
                                    aria-label="Detect my current location"
                                    title="Use my current location">

                                <svg viewBox="0 0 24 24"
                                     width="22" height="22"
                                     fill="none"
                                     stroke="currentColor"
                                     stroke-width="1.8"
                                     stroke-linecap="round"
                                     stroke-linejoin="round"
                                     aria-hidden="true">
                                    <path d="M20 10c0 5-8 12-8 12S4 15 4 10a8 8 0 1 1 16 0Z"/>
                                    <circle cx="12" cy="10" r="2.5"/>
                                </svg>
                            </button>

                            <input type="text"
                                   name="location"
                                   id="mrLocation"
                                   placeholder="Enter your area or city"
                                   aria-label="Delivery location"
                                   autocomplete="off">

                            <button type="button"
                                    id="mrClearLocation"
                                    class="mr-clear-location"
                                    aria-label="Clear location"
                                    hidden>&times;</button>
                        </div>

                        <div id="mrLocationSuggestions"
                             class="mr-location-suggestions"
                             role="listbox"></div>
                    </div>

                    <!-- FOOD SEARCH FIELD -->
                    <div class="mr-find-food">
                        <svg class="mr-search-icon"
                             viewBox="0 0 24 24"
                             width="22" height="22"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="1.8"
                             stroke-linecap="round"
                             stroke-linejoin="round"
                             aria-hidden="true">
                            <circle cx="11" cy="11" r="7"/>
                            <path d="m16 16 4 4"/>
                        </svg>

                        <input type="search"
                               name="search"
                               id="mrFoodSearch"
                               placeholder="Search biryani, pizza, burgers..."
                               aria-label="Search food or restaurants"
                               autocomplete="off"
                               required>

                        <button type="submit" class="mr-find-submit">
                            Search
                        </button>
                    </div>

                </form>

                <p id="mrLocationMessage"
                   class="mr-location-message"
                   aria-live="polite"></p>

            </div>
        </div>
    </div>
</section>


    <!-- 3. EXPLORE CUISINES -->
    <section class="mr-home-section mr-cuisine-section"
             id="mr-cuisines">

        <div class="mr-home-container">

            <div class="mr-section-heading">
                <div>
                    <span class="mr-home-kicker">A WORLD OF FLAVOUR</span>
                    <h2>Explore Cuisines</h2>
                    <p>What are you craving today?</p>
                </div>

                <a class="mr-home-link"
                   href="<%= ctx %>/restaurants">
                    Explore all →
                </a>
            </div>

            <div class="mr-cuisine-grid">

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Biryani">
                    <img
                        src="<%=ctx%>/images/biryani.png"
                        alt="Indian biryani">
                    <span>Biryani</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Pizza">
                    <img
                        src="<%=ctx%>/images/pizza.jpg"
                        alt="Pizza" loading="lazy">
                    <span>Pizza</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Burger">
                    <img
                        src="<%=ctx%>/images/burger.png"
                        alt="Burger">
                    <span>Burgers</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=South%20Indian">
                    <img
                        src="<%=ctx%>/images/south-india.jpg"
                        alt="South Indian food">
                    <span>South Indian</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Chinese">
                    <img
						src="<%=ctx%>/images/chinese-food.jpg"
						alt="chinese cuisine"> 
					<span>Chinese</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Italian">
                    <img
                        src="<%=ctx%>/images/italian.jpg"
                        alt="Italian pasta" loading="lazy">
                    <span>Italian</span>
                </a>

                <a class="mr-cuisine-item"
                   href="<%= ctx %>/restaurants?search=Dessert">
                    <img
                        src="<%=ctx%>/images/dessert.png"
                        alt="Desserts" >
                    <span>Desserts</span>
                </a>

                <a class="mr-cuisine-item mr-cuisine-all"
                   href="<%= ctx %>/restaurants">
                    <span class="mr-cuisine-all-icon">✦</span>
                    <span>View All</span>
                </a>

            </div>
        </div>
    </section>


    <!-- 4. TRENDING DISHES AND SPECIAL OFFERS -->
    <section class="mr-home-section mr-trending-section"
             id="mr-popular-dishes">

        <div class="mr-home-container">

            <div class="mr-section-heading">
                <div>
                    <span class="mr-home-kicker">FAVOURITES RIGHT NOW</span>
                    <h2>Trending Dishes</h2>
                    <p>Discover something delicious for your next meal.</p>
                </div>

                <a class="mr-home-link"
                   href="<%= ctx %>/restaurants">
                    Explore more →
                </a>
            </div>

            <div class="mr-trending-grid">

                <a class="mr-trending-card"
                   href="<%= ctx %>/restaurants?search=Biryani">
                    <img
                        src="<%=ctx%>/images/biryani-trend.png"
                        alt="Biryani" loading="lazy">
                    <div>
                        <h3>Chicken Biryani</h3>
                        <span>Explore →</span>
                    </div>
                </a>

                <a class="mr-trending-card"
                   href="<%= ctx %>/restaurants?search=Pizza">
                    <img
                        src="https://images.unsplash.com/photo-1579751626657-72bc17010498?auto=format&fit=crop&w=500&q=80"
                        alt="Pizza" loading="lazy">
                    <div>
                        <h3>Classic Pizza</h3>
                        <span>Explore →</span>
                    </div>
                </a>

                <a class="mr-trending-card"
                   href="<%= ctx %>/restaurants?search=Paneer">
                    <img
                        src="https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=500&q=80"
                        alt="Paneer curry" loading="lazy">
                    <div>
                        <h3>Paneer Curry</h3>
                        <span>Explore →</span>
                    </div>
                </a>

                <a class="mr-trending-card"
                   href="<%= ctx %>/restaurants?search=Burger">
                    <img
                        src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=80"
                        alt="Burger" loading="lazy">
                    <div>
                        <h3>Gourmet Burger</h3>
                        <span>Explore →</span>
                    </div>
                </a>

                <a class="mr-trending-card"
                   href="<%= ctx %>/restaurants?search=Pasta">
                    <img
                        src="<%=ctx%>/images/pasta.png"
                        alt="Pasta" loading="lazy">
                    <div>
                        <h3>Italian Pasta</h3>
                        <span>Explore →</span>
                    </div>
                </a>

            </div>


            <!-- SPECIAL OFFERS BANNER -->
            <div class="mr-special-offer">

                <div class="mr-special-offer-content">
                    <span class="mr-home-kicker">A LITTLE SOMETHING SPECIAL</span>

                    <h2>Make Every Meal Special</h2>

                    <p>
                        Explore restaurant menus, discover new favourites
                        and find available deals on Mana Ruchi.
                    </p>

                    <a href="<%= ctx %>/restaurants"
                       class="mr-home-featured-button">
                        Explore Restaurants <span>→</span>
                    </a>
                </div>

                <div class="mr-special-offer-image">
                    <img
                        src="<%=ctx%>/images/entire-food.jpeg"
                        alt="A delicious meal to share" loading="lazy">
                </div>

            </div>

        </div>
    </section>

</main>

<jsp:include page="/includes/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function () {

    const locationInput = document.getElementById("mrLocation");
    const locationMessage = document.getElementById("mrLocationMessage");

    if (locationInput && locationMessage) {
        locationInput.addEventListener("input", function () {
            locationMessage.textContent = "";
        });
    }

});
</script>


<script>
document.addEventListener("DOMContentLoaded", function () {

    const locationInput = document.getElementById("mrLocation");
    const locateButton = document.getElementById("mrLocateButton");
    const clearButton = document.getElementById("mrClearLocation");
    const message = document.getElementById("mrLocationMessage");
    const suggestions = document.getElementById("mrLocationSuggestions");
    const searchForm = document.getElementById("mrFindSearchForm");
    const foodInput = document.getElementById("mrFoodSearch");

    // Stop if the location search elements are not present.
    if (!locationInput || !locateButton || !clearButton ||
        !message || !suggestions || !searchForm || !foodInput) {
        console.warn("Mana Ruchi location search: required HTML elements are missing.");
        return;
    }

    let debounceTimer;
    let activeController = null;

    // Display a status message below the location input.
    function showMessage(text, type) {
        message.textContent = text;
        message.classList.remove("success", "error", "loading");

        if (type) {
            message.classList.add(type);
        }
    }

    // Hide the location suggestion list.
    function hideSuggestions() {
        suggestions.replaceChildren();
        suggestions.style.display = "none";
    }

    // Show the location suggestion list.
    function showSuggestions() {
        suggestions.style.display = "block";
    }

    // Store latitude and longitude on the location input.
    function storeCoordinates(latitude, longitude) {
        locationInput.dataset.latitude = latitude;
        locationInput.dataset.longitude = longitude;
    }

    // Remove previously stored coordinates.
    function clearCoordinates() {
        delete locationInput.dataset.latitude;
        delete locationInput.dataset.longitude;
    }

    // Get the most useful readable location from geocoding results.
    function getReadableLocation(address) {
        const area =
            address.neighbourhood ||
            address.suburb ||
            address.residential ||
            address.quarter ||
            address.city_district;

        const city =
            address.city ||
            address.town ||
            address.village ||
            address.municipality ||
            address.county;

        const state = address.state;
        const country = address.country;

        const parts = [];

        if (area) parts.push(area);
        if (city && city !== area) parts.push(city);
        if (state && state !== city) parts.push(state);
        if (country) parts.push(country);

        return parts.length
            ? parts.join(", ")
            : "Selected location";
    }

    // Add a selectable location suggestion.
    function addSuggestion(label, latitude, longitude) {
        const option = document.createElement("button");

        option.type = "button";
        option.className = "mr-location-option";
        option.textContent = label;
        option.setAttribute("role", "option");

        option.addEventListener("click", function () {
            locationInput.value = label;
            storeCoordinates(latitude, longitude);
            hideSuggestions();
            showMessage("Location selected successfully.", "success");
        });

        suggestions.appendChild(option);
    }

    // Find location suggestions using OpenStreetMap Nominatim.
    async function searchLocations(query) {
        if (activeController) {
            activeController.abort();
        }

        activeController = new AbortController();

        const controller = activeController;

        try {
            showMessage("Searching locations...", "loading");

            const url = new URL(
                "https://nominatim.openstreetmap.org/search"
            );

            url.search = new URLSearchParams({
                q: query,
                format: "jsonv2",
                addressdetails: "1",
                limit: "5",
                countrycodes: "in"
            }).toString();

            const response = await fetch(url.toString(), {
                signal: controller.signal,
                headers: {
                    "Accept": "application/json"
                }
            });

            if (!response.ok) {
                throw new Error("Location search failed.");
            }

            const results = await response.json();

            if (controller !== activeController) return;

            hideSuggestions();

            if (!results.length) {
                showMessage("No matching locations found.", "error");
                return;
            }

            results.forEach(function (place) {
                const label = getReadableLocation(
                    place.address || {}
                );

                addSuggestion(
                    label,
                    place.lat,
                    place.lon
                );
            });

            showSuggestions();
            showMessage("Choose your location from the suggestions.");
        } catch (error) {
            if (error.name === "AbortError") return;

            console.error("Location search error:", error);
            showMessage(
                "Unable to load location suggestions. Please try again.",
                "error"
            );
        }
    }

    // Search for locations when the user types.
    locationInput.addEventListener("input", function () {
        clearTimeout(debounceTimer);
        clearCoordinates();
        hideSuggestions();

        const query = locationInput.value.trim();

        if (query.length < 3) {
            showMessage(
                query.length === 0
                    ? "Enter your city or area, or use your current location."
                    : "Type at least 3 characters to search."
            );
            return;
        }

        debounceTimer = setTimeout(function () {
            searchLocations(query);
        }, 800);
    });

    // Detect the user's current GPS location.
    locateButton.addEventListener("click", function () {
        if (!navigator.geolocation) {
            showMessage(
                "Your browser does not support location detection.",
                "error"
            );
            return;
        }

        locateButton.disabled = true;
        showMessage("Detecting your current location...", "loading");
        hideSuggestions();

        navigator.geolocation.getCurrentPosition(
            async function (position) {
                const latitude = position.coords.latitude;
                const longitude = position.coords.longitude;

                try {
                    showMessage(
                        "Finding your city and area...",
                        "loading"
                    );

                    const url = new URL(
                        "https://nominatim.openstreetmap.org/reverse"
                    );

                    url.search = new URLSearchParams({
                        lat: latitude,
                        lon: longitude,
                        format: "jsonv2",
                        addressdetails: "1"
                    }).toString();

                    const response = await fetch(url.toString(), {
                        headers: {
                            "Accept": "application/json"
                        }
                    });

                    if (!response.ok) {
                        throw new Error("Reverse geocoding failed.");
                    }

                    const result = await response.json();
                    const readableLocation = getReadableLocation(
                        result.address || {}
                    );

                    locationInput.value = readableLocation;
                    storeCoordinates(latitude, longitude);

                    showMessage(
                        "Your current location has been detected.",
                        "success"
                    );
                } catch (error) {
                    console.error("Reverse geocoding error:", error);

                    // GPS worked, so retain coordinates even if the
                    // readable address service is temporarily unavailable.
                    storeCoordinates(latitude, longitude);

                    locationInput.value =
                        latitude.toFixed(5) + ", " +
                        longitude.toFixed(5);

                    showMessage(
                        "Coordinates detected, but the readable address could not be loaded.",
                        "error"
                    );
                } finally {
                    locateButton.disabled = false;
                }
            },
            function (error) {
                locateButton.disabled = false;

                let errorMessage =
                    "Unable to detect your location. Enter it manually.";

                if (error.code === error.PERMISSION_DENIED) {
                    errorMessage =
                        "Location permission was denied. Allow location access or enter your area manually.";
                } else if (error.code === error.POSITION_UNAVAILABLE) {
                    errorMessage =
                        "Your current location is unavailable. Please enter it manually.";
                } else if (error.code === error.TIMEOUT) {
                    errorMessage =
                        "Location detection timed out. Please try again.";
                }

                showMessage(errorMessage, "error");
            },
            {
                enableHighAccuracy: true,
                timeout: 20000,
                maximumAge: 60000
            }
        );
    });

    // Clear the selected location.
    clearButton.addEventListener("click", function () {
        clearTimeout(debounceTimer);

        if (activeController) {
            activeController.abort();
        }

        locationInput.value = "";
        clearCoordinates();
        hideSuggestions();

        showMessage("Location cleared. Enter your city or area.");
        locationInput.focus();
    });

    // Close suggestions when clicking outside the location field.
    document.addEventListener("click", function (event) {
        if (
            !suggestions.contains(event.target) &&
            event.target !== locationInput
        ) {
            hideSuggestions();
        }
    });

    // Keep suggestions open while the location field is focused.
    locationInput.addEventListener("focus", function () {
        if (suggestions.children.length > 0) {
            showSuggestions();
        }
    });

    // Validate the search form before submitting to RestaurantServlet.
    searchForm.addEventListener("submit", function (event) {
        const location = locationInput.value.trim();
        const food = foodInput.value.trim();

        if (!location) {
            event.preventDefault();
            showMessage("Please enter or select your location.", "error");
            locationInput.focus();
            return;
        }

        if (!food) {
            event.preventDefault();
            showMessage("Please enter a food or restaurant name.", "error");
            foodInput.focus();
            return;
        }

        // Coordinates are available in locationInput.dataset when
        // a suggestion or GPS location was selected.
        // The form currently submits its normal named input values.
    });

    // Initial status message.
    showMessage("Enter your city or area, or use your current location.");

});
</script>


</body>
</html>
