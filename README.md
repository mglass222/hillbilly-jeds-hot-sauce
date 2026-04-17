# Hillbilly Jed's Hot Sauce

Small-batch hot sauce hand crafted in North Carolina by Jeff "Jed" Briggs.

This repo is the public website for the brand. Static HTML + CSS, no build step. Checkout is handled through **Stripe Payment Links** so no backend server is required — the site can be hosted for free on GitHub Pages.

## Local preview

Just open `index.html` in any browser, or serve it:

```bash
python3 -m http.server 8000
# then visit http://localhost:8000
```

## Hooking up Stripe checkout

The "Add to the Cart" / "Grab the Trio" buttons currently point to placeholder URLs. To make them live:

1. Sign in to your [Stripe Dashboard](https://dashboard.stripe.com).
2. Go to **Payment Links** → **+ New**.
3. Create a product (name, price, image) and save it. Stripe gives you a URL like `https://buy.stripe.com/xxxxxxxxxxx`.
4. Open `index.html` and find/replace each placeholder:

   | Placeholder                              | Which button          |
   | ---------------------------------------- | --------------------- |
   | `REPLACE_WITH_ORIGINAL_LINK`             | Original Hollerin' Hot |
   | `REPLACE_WITH_REAPER_LINK`               | Smokehouse Reaper     |
   | `REPLACE_WITH_MANGO_LINK`                | Moonshine Mango Habanero |
   | `REPLACE_WITH_TRIO_LINK`                 | Whole Dang Trio bundle |

5. Commit and push. That's it — Stripe handles the checkout page, receipts, tax, and shipping address collection.

Until you replace the placeholders, clicking a Buy button pops up a friendly reminder instead of opening Stripe.

## Publishing on GitHub Pages

After pushing this repo to GitHub:

1. Repo → **Settings** → **Pages**
2. Source: **Deploy from a branch** → `main` / `/ (root)`
3. Save. Your site will be live at `https://<username>.github.io/<repo-name>/` within a minute or two.

For a custom domain (e.g. `hillbillyjeds.com`), add a `CNAME` file with the domain name and configure DNS per GitHub's Pages docs.

## File layout

```
.
├── index.html      # The whole page
├── styles.css      # All the hillbilly flavor
├── images/
│   └── banner.png  # Jed's logo/banner
├── Artwork/        # Source art (Illustrator file)
└── README.md
```

## Editing products

All product info lives in `index.html` inside the `<section id="sauces">` block. Each product is a `<article class="product-card">` with:

- Title (`<h3>`)
- Heat level (number of `<span class="pep on">` peppers — max 5)
- Description paragraph
- Price
- Buy button (Stripe link)

To add a 4th sauce, copy one of the existing `<article>` blocks, tweak the content, and the grid will flow.

## Contact

Jeff Briggs · (336) 380-3712 · Hand Crafted in North Carolina
