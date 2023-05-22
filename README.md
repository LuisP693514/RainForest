# RainForest

RainForest is an Amazon clone made with React.js and Ruby on Rails technologies as the frontend / backend frameworks (respectively). Users can interact with the site by:

- adding items to their cart
- removing items from their cart 
- purchasing items 
- creating/deleting/updating their own reviews on products

[Link to live site](https://rainforest.onrender.com)

## Technologies and Libraries Used

- React.js
- Ruby on Rails
- Node.js
- JavaScript

## Functionality

- User auth:
    - Users are able to create an account and log in/out
    - Uses CSRF protection to prevent cross-site forgery
    - Demo-user for quick access to access the logged-in features

- Shopping Cart:
    - Full CRUD
        - Users create a cart once logged in
        - For guest users: creates a new cart that gets deleted when signing in to an account
            - The items in said cart are transfered to the account's cart
        - Add items to cart
        - Remove items from cart
    
- Product Reviews:
    - Full CRUD when logged in
        - Users are able to write reviews for products they like/dislike
        - Users can edit their reviews
        - Users can delete their reviews
        - Users can read other users' reviews

## License

Pexels images license: https://www.pexels.com/license/

