# 学习笔记
## 2019-11-8
### 1.两两交换链表中的相邻节点  
题目描述：给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。

结构体构造函数
```
 Definition for singly-linked list.
 struct ListNode {
     int val;
     ListNode *next;
     ListNode(int x) : val(x), next(NULL) {}
 };

```
链表类题目常用哨兵头节点返回最终结果
```
ListNode* newHead = new ListNode(-1);

```
递归解法
```
ListNode* swapPairs(ListNode* head) {
if (head == nullptr || head->next == nullptr) {
    return head;
}

ListNode* next = head->next;
head->next = swapPairs(next->next);
next->next = head;

return next;
}
```
注意将问题拆分为子过程，考虑清楚递归出口
### 2.四数之和
题目描述：给定一个包含$n$个整数的数组$nums$和一个目标值$target$，判断$nums$中是否存在四个元素$a$，$b$，$c$ 和$d$，使得$a + b + c + d$的值$target$相等？找出所有满足条件且不重复的四元组。  
代码:
```
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        if(nums.size()<4)
            return ans;
        sort(nums.begin(),nums.end());
        int i, j, first, last;
        for(i=0;i<nums.size()-3;i++){
            for(j=i+1;j<nums.size()-2;j++){
                first = j+1;
                last = nums.size()-1;
                if((nums[i]+nums[j]+nums[first]+nums[first+1]>target)||(nums[i]+nums[j]+nums[last]+nums[last-1]<target)){
                    continue;
                }

                while(first<last){

                    while(nums[i]+nums[j]+nums[first]+nums[last]<target&&first<last){
                        first++;
                    }
                    while(nums[i]+nums[j]+nums[first]+nums[last]>target&&first<last){
                        last--;
                    }
                    
                    if(nums[i]+nums[j]+nums[first]+nums[last]==target&&first<last){
                        vector<int> tmp={nums[i],nums[j],nums[first],nums[last]};
                        ans.push_back(tmp);
                        while(nums[first]==nums[first+1]&&first+1<last){
                            first++;
                        }
                        while(nums[last]==nums[last-1]&&first+1<last){
                            last--;
                        }
                        first++;
                        last--;
                    }   
                }
                while(nums[j]==nums[j+1]&&j+1<nums.size()-1){
                    j++;
                }
            }
            while(nums[i]==nums[i+1]&&i+3<nums.size()-1){
                i++;
            }
        }
        return ans;
    }
private:
    vector<vector<int>> ans;
};
```
注意的问题：
1. 首先考虑给定数组为空或个数小于4的情况
2. 循环中要考虑数组访问越界问题
3. 注意break将会跳出整个循环
4. 去除重复元素的代码位置要考虑清楚，先执行一遍再去重
5. 去重时顺序很重要，先跳过所有重复代码后再进行操作
6. 双指针法要遍历完全，得到一个解后可能还有其他解
## 2019-11-9
### 1.两数相除
题目描述：给定两个整数，被除数$dividend$和除数$divisor$。将两数相除，要求不使用乘法、除法和$mod$运算符。
```
class Solution {
public:
    int divide(int dividend, int divisor) {
        int sign=1, ans_tmp, divisor_tmp, ans=0;
        if(dividend>0&&divisor>0||dividend<0&&divisor<0)
            sign=1;
        else
            sign=-1;
      //  dividend = (dividend>0)? -dividend:dividend;
        if(dividend>0)
            dividend=-dividend;
        //divisor = (divisor>0)? -divisor:divisor;
        if(divisor>0)
            divisor=-divisor;       
        while(dividend<=divisor){
            ans_tmp = -1;
            divisor_tmp = divisor;
            while(dividend-divisor_tmp<=(divisor_tmp)){
                if(divisor_tmp<INT_MIN-divisor_tmp){
                    break;
                }
                divisor_tmp = divisor_tmp+divisor_tmp;
                ans_tmp = ans_tmp+ans_tmp;
            }
            dividend = dividend - divisor_tmp;
            ans = ans + ans_tmp;
        }
        if(ans==INT_MIN&&sign == 1){
            return INT_MAX;
        }
        else
            return sign>0?ans*-1:ans;
        
    }
};
```
注意的问题：
1. 由于INT_MIN比INT_MAX所表示数的绝对值更大，因此将除数与被除数转换成负数
2. 在进行被除数减法运算时，要考虑效率，将被除数不断翻倍。
