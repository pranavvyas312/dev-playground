import { test, expect } from '@playwright/test';

test('verify mobile layout', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('http://localhost:8082');
  await page.waitForTimeout(2000); // Wait for animations
  await page.screenshot({ path: '/home/jules/verification/final_mobile.png' });
});
