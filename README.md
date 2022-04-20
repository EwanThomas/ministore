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
	    -  represents Product.
	  - **ProductService**
	    - requests Products from API.

### Cart Tab

-	**View**
	  - **CartViewController**
	    - displays all CartInvoice in the Cart using ProductViewCell.

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
	- provides total cost of stored products 


## Testing

Not fully tested, most critical logic is.

## Interface

UIKit, views can be easily switched out for SwiftUI.


