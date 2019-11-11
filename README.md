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
5. 去重时顺序很重要，先跳过所有重复情况后再进行操作
6. 双指针法要遍历完全，得到一个解后可能还有其他解
## 2019-11-9
### 1.两数相除
题目描述：给定两个整数，被除数$dividend$和除数$divisor$。将两数相除，要求不使用乘法、除法和$mod$运算符。
```
int divide(int dividend, int divisor) {
    int sign=1, ans_tmp, divisor_tmp, ans=0;
    if(dividend>0&&divisor>0||dividend<0&&divisor<0)
        sign=1;
    else
        sign=-1;
    if(dividend>0)
        dividend=-dividend;
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
```
注意的问题：
1. 由于INT_MIN比INT_MAX所表示数的绝对值更大，因此将除数与被除数转换成负数
2. 在进行被除数减法运算时，要考虑效率，将被除数不断翻倍。
## 2019-11-10
### 1.下一个排列
题目描述：实现获取下一个排列的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列。如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。必须原地修改，只允许使用额外常数空间。   
```
void nextPermutation(vector<int>& nums) {
    int i,j;
    i = nums.size()-2;
    while(i>=0&&nums[i]>=nums[i+1]){
        i--;
    }
    if(i>=0){
        j = nums.size()-1;
        while(nums[j]<=nums[i]){
            j--;
        }
        swap(nums[i],nums[j]);
    }
    reverse(nums,i+1);
    return ;
}
void reverse(vector<int>& nums, int i){
    int j=nums.size()-1;
    while(i<j){
        swap(nums[i],nums[j]);
        i++;
        j--;
    }
}
```
注意的问题：
1. 首先找到nums[i]<=nums[i+1]的元素，找出i右侧的刚好大于nums[i]的元素并交换
2. nums[i]之后的元素均为降序排列，将其反转
3. 思考问题时要选择复杂的case
### 2.不重复的全排列
题目描述：给定一个可包含重复数字的序列，返回所有不重复的全排列。
```
class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& nums) {
        sort(nums.begin(),nums.end());
        vector<bool> visit(nums.size(),false);
        vector<int> tmp;
        back(nums,0,visit,tmp);
        return ans;
    }
    void back(vector<int>& nums,int pos,vector<bool> visit, vector<int> tmp){
        int i;
        unordered_map<int,int> map;
        if(pos==nums.size()){
            ans.push_back(tmp);
            return ;
        }
        for(i=0;i<nums.size();i++){
            if(!visit[i]&&map.find(nums[i])==map.end()){
                map[nums[i]]=i;
                tmp.push_back(nums[i]);
                visit[i]=true;
                back(nums,pos+1,visit,tmp);
                tmp.pop_back();
                visit[i]=false;
            }
        }
    }
private:
    vector<vector<int>> ans;
};
```
注意的问题：
1. 不重复全排列需要剪枝，即在同一层递归中，重复的元素直接跳过
2. 递归过程中在某一层修改了全局性的变量需要复原
### 3.搜索旋转排序数组
题目描述：假设按照升序排序的数组在预先未知的某个点上进行了旋转。( 例如，数组[0,1,2,4,5,6,7]可能变为[4,5,6,7,0,1,2])。搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。你可以假设数组中不存在重复的元素。你的算法时间复杂度必须是$O(log n)$级别。
```
int search(vector<int>& nums, int target) {
    int left = 0;
    int right = nums.size()-1;
    int mid = left + (right-left)/2;

    while(left <= right){
        if(nums[mid] == target){
            return mid;
        }

        if(nums[left] <= nums[mid]){  //左边升序
            if(target >= nums[left] && target <= nums[mid]){//在左边范围内
                right = mid-1;
            }else{//只能从右边找
                left = mid+1;
            }

        }else{ //右边升序
            if(target >= nums[mid] && target <= nums[right]){//在右边范围内
                left = mid +1;
            }else{//只能从左边找
                right = mid-1;
            }

        }
        mid = left + (right-left)/2;
    }

    return -1;  //没找到
}
```
注意的问题：
1. 要利用好$nums[mid]$与$nums[left]$的关系来判断在哪一段中数组升序排列。
2. 要注重分析
