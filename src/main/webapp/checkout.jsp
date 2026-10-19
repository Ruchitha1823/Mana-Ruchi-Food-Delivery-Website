
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Locale" %>

<%
    Cart cart = (Cart) request.getAttribute("cart");

    if (cart == null) {
        cart = (Cart) session.getAttribute("cart");
    }

    if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/cart");
        return;
    }

    Collection<CartItem> items = cart.getItems();
    String ctx = request.getContextPath();
    double subtotal = cart.getTotal();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Mana Ruchi</title>
    <link rel="stylesheet" href="<%= ctx %>/css/checkout.css">
    <link rel="stylesheet" href="<%= ctx %>/css/navbar.css">
    <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
</head>
<body>
 <jsp:include page="/includes/navbar.jsp" />
<main class="checkout-page">

    <header class="checkout-heading">
        <span class="checkout-eyebrow">ALMOST THERE</span>
        <h1>Complete your order</h1>
        <p>Enter your delivery details and review your order before placing it.</p>
    </header>

    <form action="<%= ctx %>/place-order" method="post" id="checkoutForm">

        <div class="checkout-layout">

            <div class="checkout-card checkout-details">

                <section class="checkout-section">
                    <h2>Delivery details</h2>
                    <p class="checkout-section-description">
                        Where should we deliver your food?
                    </p>

                    <div class="checkout-fields">

                        <div class="checkout-field full-width">
                            <label for="customerName">Full name *</label>
                            <input id="customerName" name="customerName"
                                   type="text" autocomplete="name"
                                   maxlength="100" required
                                   placeholder="Enter your full name">
                        </div>

                        <div class="checkout-field">
                            <label for="phone">Mobile number *</label>
                            <input id="phone" name="phone" type="tel"
                                   autocomplete="tel" inputmode="numeric"
                                   pattern="[0-9]{10}" maxlength="10"
                                   required placeholder="10-digit mobile number">
                        </div>

                        <div class="checkout-field">
                            <label for="email">Email address</label>
                            <input id="email" name="email" type="email"
                                   autocomplete="email" maxlength="150"
                                   placeholder="you@example.com">
                        </div>

                        <div class="checkout-field full-width">
                            <label for="addressLine">House / street address *</label>
                            <input id="addressLine" name="addressLine" type="text"
                                   autocomplete="address-line1" maxlength="255"
                                   required placeholder="Flat number, building and street">
                        </div>

                        <div class="checkout-field full-width">
                            <label for="locality">Area / locality *</label>
                            <input id="locality" name="locality" type="text"
                                   autocomplete="address-line2" maxlength="150"
                                   required placeholder="Area or neighbourhood">
                        </div>

                        <div class="checkout-field">
                            <label for="city">City *</label>
                            <input id="city" name="city" type="text"
                                   autocomplete="address-level2" maxlength="100"
                                   required placeholder="City">
                        </div>

                        <div class="checkout-field">
                            <label for="state">State *</label>
                            <input id="state" name="state" type="text"
                                   autocomplete="address-level1" maxlength="100"
                                   required placeholder="State">
                        </div>

                        <div class="checkout-field">
                            <label for="pincode">PIN code *</label>
                            <input id="pincode" name="pincode" type="text"
                                   autocomplete="postal-code" inputmode="numeric"
                                   pattern="[0-9]{6}" maxlength="6"
                                   required placeholder="6-digit PIN code">
                        </div>

                        <div class="checkout-field full-width">
                            <label for="instructions">Delivery instructions (optional)</label>
                            <textarea id="instructions" name="instructions"
                                      maxlength="500"
                                      placeholder="Landmark, gate instructions or other delivery details"></textarea>
                        </div>

                    </div>
                </section>

                <section class="checkout-section">
                    <h2>Payment method</h2>
                    <p class="checkout-section-description">
                        Choose how you would like to pay.
                    </p>

                    <div class="payment-options">

                        <label class="payment-option">
                            <input type="radio" name="paymentMethod"
                                   value="COD" required checked>

                            <span class="payment-option-content">
                                <span class="payment-option-title">Cash on Delivery</span>
                                <span class="payment-option-description">
                                    Pay when your order arrives.
                                </span>
                            </span>

                            <span class="payment-selected">Available</span>
                        </label>

                        <div class="payment-option payment-disabled" aria-disabled="true">
                            <span class="payment-icon" aria-hidden="true">UPI</span>
                            <span class="payment-option-content">
                                <span class="payment-option-title">UPI / Online payment</span>
                                <span class="payment-option-description">
                                    Online payment is not enabled yet.
                                </span>
                            </span>
                            <span class="payment-coming-soon">Coming soon</span>
                        </div>

                        <div class="payment-option payment-disabled" aria-disabled="true">
                            <span class="payment-icon" aria-hidden="true">CARD</span>
                            <span class="payment-option-content">
                                <span class="payment-option-title">Credit / Debit Card</span>
                                <span class="payment-option-description">
                                    Secure payment gateway required.
                                </span>
                            </span>
                            <span class="payment-coming-soon">Coming soon</span>
                        </div>

                    </div>
                </section>
            </div>

            <aside class="checkout-card checkout-summary">

                <div class="summary-heading">
                    <div>
                        <span class="summary-kicker">YOUR SELECTION</span>
                        <h2>Order summary</h2>
                    </div>
                    <span class="summary-count"><%= items.size() %> item(s)</span>
                </div>

                <div class="checkout-items">
                    <% for (CartItem item : items) { %>
                        <div class="checkout-item">
                            <div class="checkout-item-info">
                                <div class="checkout-item-name">
                                    <%= item.getMenu().getItemName() %>
                                </div>
                                <span class="checkout-item-quantity">
                                    Qty: <%= item.getQuantity() %>
                                </span>
                            </div>

                            <span class="checkout-item-price">
                                ₹<%= String.format(Locale.US, "%.2f", item.getSubtotal()) %>
                            </span>
                        </div>
                    <% } %>
                </div>

                <div class="checkout-price-row">
                    <span>Food subtotal</span>
                    <strong>
                        ₹<%= String.format(Locale.US, "%.2f", subtotal) %>
                    </strong>
                </div>

                <div class="checkout-price-row">
                    <span>Delivery charges</span>
                    <strong class="muted-value">Calculated at order</strong>
                </div>

                <div class="checkout-price-row">
                    <span>Taxes</span>
                    <strong class="muted-value">If applicable</strong>
                </div>

                <div class="checkout-divider"></div>

                <div class="checkout-total">
                    <div>
                        <span class="total-label">Food subtotal</span>
                        <span class="total-caption">
                            Final amount confirmed after calculation
                        </span>
                    </div>
                    <strong>
                        ₹<%= String.format(Locale.US, "%.2f", subtotal) %>
                    </strong>
                </div>

                <p class="checkout-disclaimer">
                    Delivery fees and applicable taxes are not included in this subtotal.
                    The server must calculate the final payable amount before confirming the order.
                </p>

                <button type="submit" class="checkout-submit">
                    <span>Place order</span>
                    <span>→</span>
                </button>

                <a class="checkout-back" href="<%= ctx %>/cart">
                    ← Return to cart
                </a>

                <div class="checkout-secure-note">
                    <span class="secure-dot"></span>
                    Review your address before placing your order.
                </div>

            </aside>
        </div>
    </form>
</main>
 <jsp:include page="/includes/footer.jsp" />
</body>
</html>
