
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace FurnitureStore.Models
{

using System;
    using System.Collections.Generic;
    
public partial class ShoppingCart
{

    public int shoppingCartId { get; set; }

    public Nullable<int> orderId { get; set; }

    public Nullable<System.DateTime> shoppingCartDate { get; set; }

    public Nullable<int> productID { get; set; }

    public Nullable<int> quantity { get; set; }

    public Nullable<double> productSum { get; set; }



    public virtual Order Order { get; set; }

    public virtual Furniture Furniture { get; set; }

}

}
