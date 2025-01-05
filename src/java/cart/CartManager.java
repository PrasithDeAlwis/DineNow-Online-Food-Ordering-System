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
                // Increment quantity if item exists
                int currentQuantity = Integer.parseInt(item.get("quantity"));
                item.put("quantity", String.valueOf(currentQuantity + 1));
                return;
            }
        }
        
        // Add new item if it doesn't exist
        HashMap<String, String> newItem = new HashMap<>();
        newItem.put("name", name);
        newItem.put("price", price);
        newItem.put("image", image);
        newItem.put("quantity", "1");
        cart.add(newItem);
    }

    // Update item quantity
    public static void updateQuantity(HttpSession session, String itemName, String action) {
        ArrayList<HashMap<String, String>> cart = getCart(session);
        
        for (int i = 0; i < cart.size(); i++) {
            HashMap<String, String> item = cart.get(i);
            if (item.get("name").equals(itemName)) {
                int currentQuantity = Integer.parseInt(item.get("quantity"));
                
                if (action.equals("increase")) {
                    item.put("quantity", String.valueOf(currentQuantity + 1));
                } else if (action.equals("decrease")) {
                    if (currentQuantity > 1) {
                        item.put("quantity", String.valueOf(currentQuantity - 1));
                    } else {
                        cart.remove(i);
                    }
                }
                break;
            }
        }
    }

    // Calculate total price
    public static int calculateTotal(ArrayList<HashMap<String, String>> cart) {
        if (cart == null) return 0;
        
        int total = 0;
        for (HashMap<String, String> item : cart) {
            int price = Integer.parseInt(item.get("price"));
            int quantity = Integer.parseInt(item.get("quantity"));
            total += price * quantity;
        }
        return total;
    }

    // Calculate total quantity
    public static int calculateTotalQuantity(ArrayList<HashMap<String, String>> cart) {
        if (cart == null) return 0;
        
        int totalQuantity = 0;
        for (HashMap<String, String> item : cart) {
            totalQuantity += Integer.parseInt(item.get("quantity"));
        }
        return totalQuantity;
    }

    // Clear cart
    public static void clearCart(HttpSession session) {
        session.removeAttribute(CART_SESSION_KEY);
    }
}