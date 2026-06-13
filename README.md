# Hillbilly Jed's Hot Sauce

🌶️ **[View the live site →](https://mglass222.github.io/hillbilly-jeds-hot-sauce/)**

Small-batch hot sauce hand crafted in North Carolina by Jeff "Jed" Briggs.

This repo is the public website for the brand. Static HTML + CSS, no build step. Checkout is handled through **Square Online Checkout Links** so no backend server is required — the site can be hosted for free on GitHub Pages.

## Local preview

Just open `index.html` in any browser, or serve it:

```bash
python3 -m http.server 8000
# then visit http://localhost:8000
```

## Hooking up Square checkout

The "Add to the Cart" / "Grab the Trio" buttons are wired for prototype mode. They keep safe placeholder values in `data-checkout-url`, while `href="#contact"` prevents fake checkout links from shipping. To make checkout live, create Square Checkout Links and replace the placeholder `data-checkout-url` values with your Square URLs.

### 1. Create your Square account

Sign up at [squareup.com](https://squareup.com). No monthly fee on the Free plan. Online card rate is 2.9% + 30¢. You'll verify business info and link a bank account for payouts.

### 2. Add the products to your Square Item Library

In the Square dashboard: **Items & orders → Item Library → Create an item**. Add one item per sauce:

| Name | Price |
|---|---|
| Original Hollerin' Hot | $12.00 |
| Smokehouse Reaper | $16.00 |
| Moonshine Mango Habanero | $14.00 |
| The Whole Dang Trio | $38.00 |

Upload a bottle photo and set stock counts if you want inventory tracking.

### 3. Configure shipping

**Account & Settings → Fulfillment → Shipping**. Add flat-rate shipping options (for example, $6 US Standard, $15 US Priority). Square will offer these at checkout.

### 4. Create a Checkout Link for each product

In the dashboard go to **Online → Checkout Links → Create checkout link**.

For each link:
- **Link type:** "Sell an item" → pick the item you created
- Enable **Collect shipping address** (you're mailing hot sauce)
- Enable **Let customers choose quantity**
- Attach your shipping rates
- Enable **Collect tax** (Square automates US sales tax calculation)
- Save

Square gives you a short URL like `https://square.link/u/abc12345`. Copy it.

### 5. Paste the URLs into the site

Open `index.html` and replace each product button's `data-checkout-url` value with the matching Square short URL:

| Placeholder                 | Which button              |
| --------------------------- | ------------------------- |
| `TODO_ORIGINAL_SQUARE_LINK` | Original Hollerin' Hot    |
| `TODO_REAPER_SQUARE_LINK`   | Smokehouse Reaper         |
| `TODO_MANGO_SQUARE_LINK`    | Moonshine Mango Habanero  |
| `TODO_TRIO_SQUARE_LINK`     | Whole Dang Trio bundle    |

For example:
```
data-checkout-url="TODO_ORIGINAL_SQUARE_LINK"
```
becomes
```
data-checkout-url="https://square.link/u/abc12345"
```

The page script will automatically turn any `https://` checkout value into a new-tab checkout link. Until then, prototype clicks show a reminder that checkout is not live. Commit and push when the real links are in place.

### Bonus: also selling in person?

Square's killer feature — if you sell at farmers' markets, festivals, or country stores, download the free **Square POS app** on your phone. It uses the same Item Library, so every jar sold in person auto-decrements your online stock. No double-booking. Order a free tap-to-pay reader from the dashboard if you want one.

## Publishing on GitHub Pages

After pushing this repo to GitHub:

1. Repo → **Settings** → **Pages**
2. Source: **Deploy from a branch** → `main` / `/ (root)`
3. Save. Your site will be live at `https://<username>.github.io/<repo-name>/` within a minute or two.

For a custom domain (e.g. `hillbillyjeds.com`), add a `CNAME` file with the domain name and configure DNS per GitHub's Pages docs.

## File layout

```
.
├── index.html              # The whole page
├── styles.css              # All the hillbilly flavor
├── script.js               # Client-side behavior (nav, reveal, checkout wiring)
├── favicon.svg             # Browser tab icon
├── images/
│   ├── banner.webp         # Jed's logo/banner (served to modern browsers)
│   └── banner.png          # Fallback for older browsers
├── Artwork/                # Source art (Illustrator file)
├── publish-to-github.sh    # One-shot git init + gh publish helper
└── README.md
```

## Editing products

All product info lives in `index.html` inside the `<section id="sauces">` block. Each product is a `<article class="product-card">` with:

- Title (`<h3>`)
- Heat level (number of `<span class="pep on">` peppers — max 5)
- Description paragraph
- Price
- Buy button (Square checkout link)

To add a 4th sauce, copy one of the existing `<article>` blocks, tweak the content, and the grid will flow.

## Contact

Jeff Briggs · (336) 380-3712 · Hand Crafted in North Carolina
