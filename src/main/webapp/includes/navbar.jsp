
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map,java.util.Collection" %>

<%
    String navCtx = request.getContextPath();
    boolean isLoggedIn = session.getAttribute("loggedInUser") != null;

    int cartCount = 0;
    Object cartObj = session.getAttribute("cart");

    if (cartObj instanceof Map<?, ?>) {
        for (Object value : ((Map<?, ?>) cartObj).values()) {
            cartCount += value instanceof Number
                    ? Math.max(0, ((Number) value).intValue()) : 1;
        }
    } else if (cartObj instanceof Collection<?>) {
        cartCount = ((Collection<?>) cartObj).size();
    } else if (cartObj != null) {
        try {
            Object items = cartObj.getClass().getMethod("getItems").invoke(cartObj);
            if (items instanceof Map<?, ?>) {
                for (Object value : ((Map<?, ?>) items).values()) {
                    cartCount += value instanceof Number
                            ? Math.max(0, ((Number) value).intValue()) : 1;
                }
            } else if (items instanceof Collection<?>) {
                cartCount = ((Collection<?>) items).size();
            }
        } catch (Exception ignored) {
            cartCount = 0;
        }
    }
%>

<link rel="stylesheet" href="<%= navCtx %>/assets/css/navbar.css">

<header class="mr-header">
    <div class="mr-navbar">

        <!-- Brand -->
        <a class="mr-brand" href="<%= navCtx %>/home.jsp"
           aria-label="Mana Ruchi home">
            <img class="mr-logo"
                 src="<%= navCtx %>/images/logo.png"
                 alt="Mana Ruchi logo">
            <span class="mr-brand-copy">
                <span class="mr-brand-name">Mana Ruchi</span>
                <span class="mr-brand-tagline">Your cravings, our care.</span>
            </span>
        </a>

        <!-- Delivery location -->
        <div class="mr-location">
            <div class="mr-location-top">
                <!-- Orange map-pin icon -->
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M20 10c0 5-8 12-8 12S4 15 4 10a8 8 0 1 1 16 0Z"/>
                    <circle cx="12" cy="10" r="2.5"/>
                </svg>
            </div>

            <div class="mr-location-field">
                <input type="text"
                       id="mrLocationInput"
                       placeholder="Choose your location"
                       aria-label="Delivery area and city"
                       autocomplete="street-address">

                <button type="button"
                        id="mrDetectLocation"
                        class="mr-location-button"
                        title="Use my current location"
                        aria-label="Use my current location">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <circle cx="12" cy="12" r="7"/>
                        <circle cx="12" cy="12" r="2"/>
                        <path d="M12 2v3M12 19v3M2 12h3M19 12h3"/>
                    </svg>
                </button>
            </div>

            <span id="mrLocationMessage"
                  class="mr-location-message"
                  role="status"
                  aria-live="polite"></span>
        </div>

        <!-- Search -->
        <form class="mr-search"
              action="<%= navCtx %>/restaurants"
              method="get"
              role="search">
            <svg class="mr-search-icon" viewBox="0 0 24 24" aria-hidden="true">
                <circle cx="11" cy="11" r="7"/>
                <path d="m16 16 5 5"/>
            </svg>

            <input type="search"
                   name="q"
                   placeholder="Search dishes or restaurants"
                   aria-label="Search dishes and restaurants">

            <button type="submit" aria-label="Submit search">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M5 12h14M13 6l6 6-6 6"/>
                </svg>
            </button>
        </form>

        <!-- Desktop links AFTER search -->
        <nav class="mr-desktop-nav" aria-label="Main navigation">
            <a href="<%= navCtx %>/home.jsp" class="mr-nav-link">Home</a>
            <a href="<%= navCtx %>/restaurants" class="mr-nav-link">Restaurants</a>
        </nav>

        <!-- Cart, account and mobile menu -->
        <div class="mr-actions">
            <a href="<%= navCtx %>/cart"
               class="mr-cart"
               aria-label="Cart<%= cartCount > 0 ? ", " + cartCount + " items" : "" %>">
                <span class="mr-cart-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M3 3h2l2.4 11.5a2 2 0 0 0 2 1.5h8.8a2 2 0 0 0 2-1.6L22 8H6"/>
                        <circle cx="10" cy="20" r="1.3"/>
                        <circle cx="18" cy="20" r="1.3"/>
                    </svg>
                    <% if (cartCount > 0) { %>
                        <span class="mr-cart-count"><%= cartCount %></span>
                    <% } %>
                </span>
                <span class="mr-cart-label">Cart</span>
            </a>

            <% if (isLoggedIn) { %>
                <div class="mr-account">
                    <button type="button"
                            class="mr-account-button"
                            id="mrAccountButton"
                            aria-expanded="false"
                            aria-controls="mrAccountMenu">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <circle cx="12" cy="8" r="4"/>
                            <path d="M4 21a8 8 0 0 1 16 0"/>
                        </svg>
                        <span>Account</span>
                        <svg class="mr-chevron" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="m7 10 5 5 5-5"/>
                        </svg>
                    </button>
                    <div class="mr-account-menu" id="mrAccountMenu">
                        <a href="<%= navCtx %>/profile">My Profile</a>
                        <a href="<%= navCtx %>/orders">My Orders</a>
                        <a href="<%= navCtx %>/logout">Logout</a>
                    </div>
                </div>
            <% } else { %>
                <button type="button" class="mr-login-button" id="mrOpenLogin">
                    Login
                </button>
            <% } %>

            <button type="button"
                    class="mr-menu-toggle"
                    id="mrMenuToggle"
                    aria-label="Open navigation menu"
                    aria-expanded="false"
                    aria-controls="mrMobileMenu">
                <span></span><span></span><span></span>
            </button>
        </div>
    </div>

    <!-- Mobile navigation: Offers removed -->
    <nav class="mr-mobile-menu" id="mrMobileMenu" aria-label="Mobile navigation">
        <a href="<%= navCtx %>/home.jsp">Home</a>
        <a href="<%= navCtx %>/restaurants">Restaurants</a>

        <% if (isLoggedIn) { %>
            <a href="<%= navCtx %>/profile">My Profile</a>
            <a href="<%= navCtx %>/orders">My Orders</a>
            <a href="<%= navCtx %>/logout">Logout</a>
        <% } else { %>
            <button type="button" id="mrMobileLogin">Login to your account</button>
        <% } %>
    </nav>
</header>

<!-- Login modal -->
<% if (!isLoggedIn) { %>
<div class="mr-login-overlay" id="mrLoginModal" aria-hidden="true">
    <section class="mr-login-dialog"
             role="dialog"
             aria-modal="true"
             aria-labelledby="mrLoginTitle">

        <button type="button" class="mr-modal-close" id="mrCloseLogin"
                aria-label="Close login dialog">&times;</button>

        <div class="mr-modal-mark">MR</div>
        <p class="mr-modal-eyebrow">WELCOME TO MANA RUCHI</p>
        <h2 id="mrLoginTitle">Good food starts here.</h2>
        <p class="mr-modal-description">Sign in to continue to your favourite meals.</p>

        <form action="<%= navCtx %>/login" method="post">
            <label for="mrLoginEmail">Email address</label>
            <input type="email" name="email" id="mrLoginEmail"
                   autocomplete="email" placeholder="you@example.com" required>

            <label for="mrLoginPassword">Password</label>
            <input type="password" name="password" id="mrLoginPassword"
                   autocomplete="current-password" placeholder="Enter your password" required>

            <button type="submit" class="mr-login-submit">Sign in</button>
        </form>

        <p class="mr-register-prompt">
            New to Mana Ruchi?
            <a href="<%= navCtx %>/register.jsp">Create an account</a>
        </p>
    </section>
</div>
<% } %>

<script>
(function () {
    const locationInput = document.getElementById("mrLocationInput");
    const locationMessage = document.getElementById("mrLocationMessage");
    const detectButton = document.getElementById("mrDetectLocation");

    function saveLocation() {
        const value = locationInput.value.trim();
        try {
            if (value) sessionStorage.setItem("mrDeliveryLocation", value);
            else sessionStorage.removeItem("mrDeliveryLocation");
        } catch (e) {}
    }

    try {
        const saved = sessionStorage.getItem("mrDeliveryLocation");
        if (saved) locationInput.value = saved;
    } catch (e) {}

    locationInput.addEventListener("change", saveLocation);
    locationInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            event.preventDefault();
            saveLocation();
            locationInput.blur();
        }
    });

    // Convert coordinates into a readable area and city.
    async function getAreaAndCity(latitude, longitude) {
        const url = new URL("https://nominatim.openstreetmap.org/reverse");
        url.search = new URLSearchParams({
            format: "jsonv2",
            lat: latitude,
            lon: longitude,
            zoom: "14",
            addressdetails: "1"
        });

        const response = await fetch(url.toString());
        if (!response.ok) throw new Error("Address lookup failed");

        const data = await response.json();
        const a = data.address || {};

        const area = a.suburb || a.neighbourhood || a.residential ||
                     a.city_district || a.quarter || a.town || a.village || "";

        const city = a.city || a.town || a.municipality ||
                     a.city_district || a.village || a.county || "";

        const parts = [...new Set([area, city].filter(Boolean))];
        if (!parts.length) throw new Error("Area not found");
        return parts.join(", ");
    }

    detectButton.addEventListener("click", function () {
        if (!navigator.geolocation) {
            locationMessage.textContent =
                "Location is unavailable. Please enter your area and city.";
            return;
        }

        detectButton.disabled = true;
        locationMessage.textContent = "Finding your area and city…";

        navigator.geolocation.getCurrentPosition(async function (position) {
            try {
                const place = await getAreaAndCity(
                    position.coords.latitude,
                    position.coords.longitude
                );
                locationInput.value = place;
                saveLocation();
                locationMessage.textContent = "Delivery location updated.";
            } catch (error) {
                locationMessage.textContent =
                    "Could not find the area name. Please enter it manually.";
            } finally {
                detectButton.disabled = false;
            }
        }, function (error) {
            if (error.code === error.PERMISSION_DENIED) {
                locationMessage.textContent =
                    "Location permission denied. Enter your area and city manually.";
            } else if (error.code === error.TIMEOUT) {
                locationMessage.textContent =
                    "Location request timed out. Please try again.";
            } else {
                locationMessage.textContent =
                    "Could not detect location. Please enter it manually.";
            }
            detectButton.disabled = false;
        }, {
            enableHighAccuracy: true,
            timeout: 12000,
            maximumAge: 60000
        });
    });

    // Mobile navigation
    const menuToggle = document.getElementById("mrMenuToggle");
    const mobileMenu = document.getElementById("mrMobileMenu");

    function closeMobileMenu() {
        mobileMenu.classList.remove("mr-mobile-menu-open");
        menuToggle.setAttribute("aria-expanded", "false");
        menuToggle.setAttribute("aria-label", "Open navigation menu");
    }

    menuToggle.addEventListener("click", function () {
        const open = mobileMenu.classList.toggle("mr-mobile-menu-open");
        menuToggle.setAttribute("aria-expanded", String(open));
        menuToggle.setAttribute("aria-label",
            open ? "Close navigation menu" : "Open navigation menu");
    });

    mobileMenu.querySelectorAll("a").forEach(function (link) {
        link.addEventListener("click", closeMobileMenu);
    });

    // Account dropdown
    const accountButton = document.getElementById("mrAccountButton");
    const accountMenu = document.getElementById("mrAccountMenu");

    if (accountButton && accountMenu) {
        accountButton.addEventListener("click", function (event) {
            event.stopPropagation();
            const open = accountMenu.classList.toggle("mr-account-menu-open");
            accountButton.setAttribute("aria-expanded", String(open));
        });

        document.addEventListener("click", function (event) {
            if (!event.target.closest(".mr-account")) {
                accountMenu.classList.remove("mr-account-menu-open");
                accountButton.setAttribute("aria-expanded", "false");
            }
        });
    }

    // Login modal
    const modal = document.getElementById("mrLoginModal");
    const openButton = document.getElementById("mrOpenLogin");
    const mobileLogin = document.getElementById("mrMobileLogin");
    const closeButton = document.getElementById("mrCloseLogin");

    function openModal() {
        if (!modal) return;
        closeMobileMenu();
        modal.classList.add("mr-login-overlay-open");
        modal.setAttribute("aria-hidden", "false");
        document.body.classList.add("mr-login-lock");

        const email = document.getElementById("mrLoginEmail");
        if (email) email.focus();
    }

    function closeModal() {
        if (!modal) return;
        modal.classList.remove("mr-login-overlay-open");
        modal.setAttribute("aria-hidden", "true");
        document.body.classList.remove("mr-login-lock");
    }

    if (openButton) openButton.addEventListener("click", openModal);
    if (mobileLogin) mobileLogin.addEventListener("click", openModal);
    if (closeButton) closeButton.addEventListener("click", closeModal);

    if (modal) {
        modal.addEventListener("click", function (event) {
            if (event.target === modal) closeModal();
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                closeModal();
                closeMobileMenu();
                if (accountMenu && accountButton) {
                    accountMenu.classList.remove("mr-account-menu-open");
                    accountButton.setAttribute("aria-expanded", "false");
                }
            }
        });

        if (new URLSearchParams(window.location.search).get("error") === "invalid") {
            openModal();
        }
    }
})();
</script>
