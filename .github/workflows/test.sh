name: test images

on:
  schedule:
    - cron: '45 0 * * *'
  workflow_dispatch:

jobs:
  test_images:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: check path
      run: |
        pwd
      
    - name: test images
      run: |
        bash test.sh
        
    - name: Configure Git
      run: |
        git config --global user.name "daily-update"
        git config --global user.email "tg@spiritlhl.top"
      
    - name: Add files to Git staging area
      run: |
        ls
        pwd
        git add .
        
    - name: Check Git status
      run: |
        git branch -a
        git remote -v
        git status
    
    - name: Commit changes
      run: |
        git commit -m "Update files" | true
    
    - name: Push changes
      uses: ad-m/github-push-action@master
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
