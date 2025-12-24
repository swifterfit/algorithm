class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var ans = 0
        for i in 0..<prices.count {
            if prices[i] > prices[i - 1] {
                ans += prices[i] - prices[i - 1]
            }
        }
        return ans
    }
}