package cart;

import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

public class CartManager {
    private static final String CART_SESSION_KEY = "cart";

    // Get cart from session, create if doesn't exist
    private static ArrayList<HashMap<String, String>> getCart(HttpSession session) {
        @SuppressWarnings("unchecked")
        ArrayList<HashMap<String, String>> cart = 
            (ArrayList<HashMap<String, String>>) session.getAttribute(CART_SESSION_KEY);
        
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        
        return cart;
    }

    // Add item to cart
    public static void addItem(HttpSession session, String name, String price, String image) {
        ArrayList<HashMap<String, String>> cart = getCart(session);
        
        // Check if item already exists in cart
        for (HashMap<String, String> item : cart) {
            if (item.get("name").equals(name)) {
                // If exists, increment quantity
                int quantity = Integer.parseInt(item.get("quantity"));
                item.put("quantity", String.valueOf(quantity + 1));
                return;
            }
        }
        
        // If item doesn't exist, add new item
        HashMap<String, String> newItem = new HashMap<>();
        newItem.put("name", name);
        newItem.put("price", price);
        newItem.put("image", image);
        newItem.put("quantity", "1");
        cart.add(newItem);
    }

    // Remove item from cart
    public static void removeItem(HttpSession session, String name) {
        ArrayList<HashMap<String, String>> cart = getCart(session);
        cart.removeIf(item -> item.get("name").equals(name));
    }

    // Update item quantity
    public static void updateQuantity(HttpSession session, String name, String action) {
        ArrayList<HashMap<String, String>> cart = getCart(session);
        
        for (HashMap<String, String> item : cart) {
            if (item.get("name").equals(name)) {
                int currentQuantity = Integer.parseInt(item.get("quantity"));
                int newQuantity = currentQuantity;
                
                if (action.equals("increase")) {
                    newQuantity = currentQuantity + 1;
                } else if (action.equals("decrease")) {
                    newQuantity = currentQuantity - 1;
                }
                
                if (newQuantity <= 0) {
                    removeItem(session, name);
                } else {
                    item.put("quantity", String.valueOf(newQuantity));
                }
                return;
            }
        }
    }

    // Calculate total price
    public static double getTotal(HttpSession session) {
        ArrayList<HashMap<String, String>> cart = getCart(session);
        double total = 0.0;
        
        for (HashMap<String, String> item : cart) {
            double price = Double.parseDouble(item.get("price"));
            int quantity = Integer.parseInt(item.get("quantity"));
            total += price * quantity;
        }
        
        return total;
    }

    // Get cart items
    public static ArrayList<HashMap<String, String>> getItems(HttpSession session) {
        return getCart(session);
    }

    // Clear cart
    public static void clearCart(HttpSession session) {
        session.removeAttribute(CART_SESSION_KEY);
    }
}