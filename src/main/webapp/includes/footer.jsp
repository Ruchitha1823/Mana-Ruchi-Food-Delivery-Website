<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    String ctx = request.getContextPath();
%>

<!-- ===================== FOOTER ===================== -->

<footer class="home-footer">
    <div class="home-container">

        <div class="home-footer-main">

            <!-- Brand -->
            <div>
                <a class="home-brand"
                   href="<%= ctx %>/home.jsp">

                    <span class="home-brand-mark">MR</span>

                    <span class="home-brand-copy">
                        <span class="home-brand-name">Mana Ruchi</span>
                        <span class="home-brand-tagline">MADE WITH LOVE</span>
                    </span>

                </a>

                <p class="home-footer-about">
                    Discover great food, explore local restaurants
                    and enjoy a simpler way to find your next meal.
                    Good food, delivered with care.
                </p>
            </div>

            <!-- Explore -->
            <div>
                <h3>Explore</h3>

                <div class="home-footer-links">
                    <a href="<%= ctx %>/home.jsp">Home</a>
                    <a href="<%= ctx %>/home.jsp#cuisines">Cuisines</a>
                    <a href="<%= ctx %>/home.jsp#popular">Popular picks</a>
                    <a href="<%= ctx %>/restaurants">Restaurants</a>
                </div>
            </div>

            <!-- Orders -->
            <div>
                <h3>Your order</h3>

                <div class="home-footer-links">
                    <a href="<%= ctx %>/restaurants">Browse restaurants</a>
                    <a href="<%= ctx %>/cart">View cart</a>
                    <a href="<%= ctx %>/checkout">Checkout</a>
                </div>
            </div>

        </div>

        <!-- Copyright -->
        <div class="home-footer-bottom">
            <span>
                &copy; <%= java.time.Year.now().getValue() %>
                Mana Ruchi. All rights reserved.
            </span>

            <span>GOOD FOOD, DELIVERED WITH CARE.</span>
        </div>

    </div>
</footer>