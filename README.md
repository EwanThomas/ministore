
# Shortcuts

Time is **very** tight for me at the moment and so there are at least two shortcuts.

#### Image caching 
Image caching is necessary for a decent UX in my opinion and so I am using Kingfisher via SPM.

After cloning if the app does not compile please do `File ` -> `Packages` -> `Reset Package Caches`.

#### Error handling
Errors are not handled the view layer, they are everywhere else though.


# Architecture

## MVVM

Standard MVVM with Combine bindings between views and view models and view models and models.

### Components

#### Product Tab
-	**View**
	  - **ProductViewCell**
	    - displays a single product.
	  - **ProductViewController**
	    - displays all products using ProductViewCell.

-	**View Model**
	  - **ProductsViewModel**
	    -  manages view state for ProductViewController.
	    - provides products to ProductViewController.
	  - **ProductCellViewModel**
	    - manages view state for ProductViewCell.
	    - add and removes products to Cart.

-	**Model**
	  - **Product**
	    -  represents a Product.
	  - **ProductService**
	    - requests Products from API.

### Cart Tab

-	**View**
	  - **CartViewController**
	    - displays CartInvoice in the Cart using ProductViewCell.

-	**View Model**
	  - **CartViewModel**
		  - manages view state for CartViewController.
		  - provides CartInvoice from the Cart to CartViewController.

-	**Model**
	  - **CartInvoice**
		  -  represents the number of individual items in the cart and their total cost.

### Shared component
- **Cart**	
	- Stores products 
	- provides quantities for all or individual products 
	- provides total cost of all stored products 


## Testing

Not fully testet but most critical logic is.

## Interface

UIKit but views can be easily switched out for SwiftUI without changing view models or models.


## Pull requests and commits

I have squashed commits to `Main` but you can see stale branches and commits here:

https://github.com/EwanThomas/ministore/pulls?q=is%3Apr+is%3Amerged

https://github.com/EwanThomas/ministore/branches


