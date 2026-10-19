<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Collection" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null) {
        cart = new Cart();
    }

    Collection<CartItem> cartItems = cart.getItems();
    boolean isCartEmpty = cartItems == null || cartItems.isEmpty();
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Cart | Mana Ruchi</title>

    <link rel="stylesheet"
          href="<%= ctx %>/css/cart.css">
    <link rel="stylesheet"
          href="<%= ctx %>/css/navbar.css">
    <link rel="stylesheet"
          href="<%= ctx %>/css/footer.css">
</head>

<body>

    <%-- Shared navbar --%>
    <jsp:include page="/includes/navbar.jsp" />

    <main class="mr-cart-page">

        <section class="mr-cart-heading">
            <div>
                <span class="mr-eyebrow">YOUR FOOD SELECTION</span>
                <h1>Your Cart</h1>
                <p>Review your favourites before placing your order.</p>
            </div>

            <a href="<%= ctx %>/restaurants" class="mr-continue-link">
                <span aria-hidden="true">←</span> Continue shopping
            </a>
        </section>

        <% if (isCartEmpty) { %>

            <section class="mr-empty-cart">
                <div class="mr-empty-icon" aria-hidden="true">🥗</div>
                <span class="mr-eyebrow">NOTHING HERE YET</span>

                <h2>Your cart is waiting for something delicious</h2>

                <p>
                    Explore our restaurants and add your favourite dishes
                    to get started.
                </p>

                <a href="<%= ctx %>/restaurants" class="mr-primary-button">
                    Explore Restaurants
                    <span aria-hidden="true">→</span>
                </a>
            </section>

        <% } else { %>

            <div class="mr-cart-layout">

                <section class="mr-cart-card">

                    <div class="mr-cart-card-header">
                        <div>
                            <h2>Your selected dishes</h2>
                            <p>
                                <%= cartItems.size() %>
                                <%= cartItems.size() == 1 ? "item" : "items" %>
                            </p>
                        </div>

                        <span class="mr-cart-status">
                            <span class="mr-status-dot"></span>
                            Ready to order
                        </span>
                    </div>

                    <div class="mr-cart-items">

                        <% for (CartItem cartItem : cartItems) {

                            double price = cartItem.getMenu().getPrice();
                            int quantity = cartItem.getQuantity();
                            double subtotal = cartItem.getSubtotal();

                            String imagePath = cartItem.getMenu().getImagePath();
                            String itemName = cartItem.getMenu().getItemName();
                        %>

                            <article class="mr-cart-item">

                                <div class="mr-item-image-wrap">
                                    <img
                                        src="<%= imagePath == null || imagePath.trim().isEmpty()
                                            ? ctx + "/images/food-placeholder.png"
                                            : imagePath %>"
                                        alt="<%= itemName %>"
                                        class="mr-item-image"
                                        onerror="this.onerror=null;this.src='<%= ctx %>/images/food-placeholder.png';"
                                    >
                                </div>

                                <div class="mr-item-details">
                                    <h3><%= itemName %></h3>

                                    <p class="mr-item-unit-price">
                                        ₹<%= String.format("%.2f", price) %>
                                        <span>per item</span>
                                    </p>

							<form action="${pageContext.request.contextPath}/cart"
								method="post" class="mr-remove-form">

								<input type="hidden" name="action" value="remove"> 
							    <input type="hidden" name="returnTo" value="cart">	
								<input
									type="hidden" name="menuId"
									value="<%=cartItem.getMenu().getMenuId()%>">

								<button type="submit" class="mr-remove-button"
									aria-label="Remove <%=cartItem.getMenu().getItemName()%> from cart">
									<svg class="mr-delete-icon" xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 24 24" width="15" height="15" fill="none"
										stroke="currentColor" stroke-width="1.8"
										stroke-linecap="round" stroke-linejoin="round"
										aria-hidden="true">
                                        <path d="M3 6h18" />
                                        <path d="M8 6V4h8v2" />
                                        <path d="M19 6l-1 14H6L5 6" />
                                        <path d="M10 11v5" />
                                        <path d="M14 11v5" />
                                       </svg>
									<span>Remove</span>
								</button>
							</form>
						</div>

                                <div class="mr-item-controls">

                                    <div class="mr-quantity-control">

                                        <form action="<%= ctx %>/cart"
                                              method="post">

                                            <input type="hidden"
                                                   name="action"
                                                   value="update">
                                             <input type="hidden" name="returnTo" value="cart">

                                            <input type="hidden"
                                                   name="menuId"
                                                   value="<%= cartItem.getMenu().getMenuId() %>">

                                            <input type="hidden"
                                                   name="quantity"
                                                   value="<%= quantity - 1 %>">

                                            <button type="submit"
                                                    class="mr-quantity-button"
                                                    aria-label="Decrease quantity"
                                                    <%= quantity <= 1 ? "disabled" : "" %>>
                                                −
                                            </button>
                                        </form>

                                        <span class="mr-quantity">
                                            <%= quantity %>
                                        </span>

                                        <form action="<%= ctx %>/cart"
                                              method="post">

                                            <input type="hidden"
                                                   name="action"
                                                   value="update">
                                                   
                                            <input type="hidden" name="returnTo" value="cart">
                                            <input type="hidden"
                                                   name="menuId"
                                                   value="<%= cartItem.getMenu().getMenuId() %>">

                                            <input type="hidden"
                                                   name="quantity"
                                                   value="<%= quantity + 1 %>">

                                            <button type="submit"
                                                    class="mr-quantity-button"
                                                    aria-label="Increase quantity">
                                                +
                                            </button>
                                        </form>

                                    </div>

                                    <div class="mr-item-subtotal">
                                        ₹<%= String.format("%.2f", subtotal) %>
                                    </div>

                                </div>

                            </article>

                        <% } %>

                    </div>

                    <div class="mr-cart-footer-actions">

                        <a href="<%= ctx %>/restaurants"
                           class="mr-back-link">
                            <span aria-hidden="true">←</span>
                            Add more dishes
                        </a>

                        <form action="<%= ctx %>/cart" method="post"
                              onsubmit="return confirm('Are you sure you want to clear your cart?');">

                            <input type="hidden"
                                   name="action"
                                   value="clear">

                            <button type="submit" class="mr-clear-button">
                                Clear cart
                            </button>
                        </form>

                    </div>

                </section>

                <aside class="mr-order-summary">

                    <span class="mr-eyebrow">YOUR ORDER</span>
                    <h2>Order Summary</h2>

                    <div class="mr-summary-row">
                        <span>Items</span>
                        <span><%= cartItems.size() %></span>
                    </div>

                    <div class="mr-summary-row">
                        <span>Subtotal</span>
                        <span>₹<%= String.format("%.2f", cart.getTotal()) %></span>
                    </div>

                    <div class="mr-summary-row mr-delivery-row">
                        <span>Delivery charges</span>
                        <span class="mr-free-label">Calculated at checkout</span>
                    </div>

                    <div class="mr-summary-divider"></div>

                    <div class="mr-total-row">
                        <span>Total</span>
                        <strong>
                            ₹<%= String.format("%.2f", cart.getTotal()) %>
                        </strong>
                    </div>

                    <p class="mr-summary-note">
                        Final charges, if applicable, will be shown during checkout.
                    </p>

                    <form action="<%= ctx %>/checkout" method="post">
                        <button type="submit" class="mr-checkout-button">
                            Proceed to Checkout
                            <span aria-hidden="true">→</span>
                        </button>
                    </form>

                    <div class="mr-secure-note">
                        <span aria-hidden="true">✓</span>
                        Review your order before confirming
                    </div>

                </aside>

            </div>

        <% } %>

    </main>

    <%-- Shared footer --%>
    <jsp:include page="/includes/footer.jsp" />
    
   
</body>
</html>
